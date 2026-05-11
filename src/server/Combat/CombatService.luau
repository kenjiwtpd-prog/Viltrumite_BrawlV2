local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)
local Constants = require(Shared.Combat.Constants)
local Roster = require(Shared.Characters.Roster)
local Math2D = require(Shared.Util.Math2D)
local Debug = require(Shared.Config.Debug)

local FighterController = require(script.Parent.FighterController)
local SelectionService = require(script.Parent.Parent.Player.SelectionService)
local HitboxService -- resolved at Start

local CombatService = {}
CombatService.fighters = {} :: { [Player]: any }

local DEFAULT_CHARACTER = "Conquest"

local function selectionFor(plr: Player): string
	return SelectionService:Get(plr) or DEFAULT_CHARACTER
end

local accumulator = 0

function CombatService:Start()
	HitboxService = require(script.Parent.HitboxService)

	Players.PlayerAdded:Connect(function(plr) self:_hook(plr) end)
	for _, plr in Players:GetPlayers() do self:_hook(plr) end
	Players.PlayerRemoving:Connect(function(plr) self.fighters[plr] = nil end)

	Remotes.get("InputCommand").OnServerEvent:Connect(function(plr, payload)
		local f = self.fighters[plr]
		if not f or not payload then return end
		if type(payload.action) == "string" and type(payload.pressed) == "boolean" then
			f:handleInput(payload.action, payload.pressed)
		end
	end)

	RunService.Heartbeat:Connect(function(dt) self:_step(dt) end)

	if Debug.LogStateChanges then print("[CombatService] started") end
end

function CombatService:_hook(plr: Player)
	plr.CharacterAdded:Connect(function(char) self:_onCharacter(plr, char) end)
	if plr.Character then self:_onCharacter(plr, plr.Character) end
end

function CombatService:_onCharacter(plr: Player, char: Model)
	char:WaitForChild("HumanoidRootPart", 5)
	char:WaitForChild("Humanoid", 5)
	local id = selectionFor(plr)
	self.fighters[plr] = FighterController.new(plr, char, id)
	self:_updateFacing(self.fighters[plr])
end

function CombatService:_updateFacing(fighter)
	if not fighter.root then return end
	local nearest, nearestDist
	for _, other in self.fighters do
		if other ~= fighter and other.root then
			local d = (other.root.Position - fighter.root.Position).Magnitude
			if not nearestDist or d < nearestDist then
				nearest, nearestDist = other, d
			end
		end
	end
	if nearest then
		fighter.facing = Math2D.facingFromTo(fighter.root.Position, nearest.root.Position)
	end
end

function CombatService:_step(dt: number)
	accumulator += dt
	while accumulator >= Constants.FrameTime do
		accumulator -= Constants.FrameTime
		self:_frame()
	end
end

function CombatService:_frame()
	local list = {}
	for _, f in self.fighters do
		if f:isAlive() then table.insert(list, f) end
	end
	for _, f in list do self:_updateFacing(f) end

	for _, f in list do
		f:tick(list, HitboxService, function(attacker, victim) self:_onHit(attacker, victim) end)
	end
end

function CombatService:_onHit(attacker, victim)
	local move = attacker.currentMove
	if not move then return end
	victim:applyHit(move.damage, move.hitstun, move.knockback)

	Remotes.get("HitConfirmed"):FireAllClients({
		attackerId = attacker.player.UserId,
		victimId = victim.player.UserId,
		moveName = move.name,
		damage = move.damage,
	})
	Remotes.get("CameraShake"):FireAllClients({ amount = math.clamp(move.damage / 40, 0.15, 0.6) })
end

function CombatService:GetFighter(plr: Player) return self.fighters[plr] end

return CombatService
