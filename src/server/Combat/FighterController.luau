local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))

local FighterState = require(Shared.State.FighterState)
local Constants = require(Shared.Combat.Constants)
local Roster = require(Shared.Characters.Roster)
local Tuning = require(Shared.Config.Tuning)
local Debug = require(Shared.Config.Debug)

local MoveDefsFolder = Shared.Combat.MoveDefs

local FighterController = {}
FighterController.__index = FighterController

function FighterController.new(player: Player, character: Model, characterId: string)
	local stats = Roster[characterId] or Roster.Conquest
	local movesetModule = MoveDefsFolder:FindFirstChild(stats.movesetModule)
	local moveset = movesetModule and require(movesetModule) or {}

	local self = setmetatable({
		player = player,
		character = character,
		humanoid = character:FindFirstChildOfClass("Humanoid"),
		root = character:FindFirstChild("HumanoidRootPart"),
		characterId = characterId,
		stats = stats,
		moveset = moveset,
		state = FighterState.new(),
		health = stats.maxHealth,
		facing = Constants.FacingRight,
		currentMove = nil :: any,
		hitTargets = {} :: { [Player]: boolean },
		hitstunFrames = 0,
	}, FighterController)
	return self
end

function FighterController:isAlive(): boolean
	return self.health > 0 and self.character and self.character.Parent ~= nil
end

function FighterController:startMove(moveName: string): boolean
	local move = self.moveset[moveName]
	if not move then return false end
	if not self.state:set(FighterState.States.Attack) then return false end
	self.currentMove = move
	self.hitTargets = {}
	if Debug.LogStateChanges then
		print(("[Fighter %s] start move %s"):format(self.player.Name, moveName))
	end
	return true
end

function FighterController:applyHit(damage: number, hitstunFrames: number, knockback: Vector3)
	self.health = math.max(0, self.health - damage * Tuning.GlobalDamageScale)
	self.hitstunFrames = hitstunFrames
	self.currentMove = nil
	self.state:set(FighterState.States.Hitstun)
	if self.root and knockback.Magnitude > 0 then
		local kb = Vector3.new(knockback.X * -self.facing, knockback.Y, 0) * Tuning.KnockbackScale
		self.root.AssemblyLinearVelocity = kb
	end
	if self.health <= 0 then
		self.state:set(FighterState.States.KO)
	end
end

function FighterController:handleInput(action: string, pressed: boolean)
	if not pressed then return end
	if self.state.current == FighterState.States.Hitstun then return end
	if self.state.current == FighterState.States.KO then return end

	if action == "LightAttack" then
		self:startMove("LightPunch")
	end
end

function FighterController:tick(opponents: { any }, hitboxService: any, onHit: (FighterController, FighterController) -> ())
	self.state:tick()

	if self.hitstunFrames > 0 then
		self.hitstunFrames -= 1
		if self.hitstunFrames == 0 and self.state.current == FighterState.States.Hitstun then
			self.state:set(FighterState.States.Idle)
		end
	end

	local move = self.currentMove
	if not move then return end
	if self.state.current ~= FighterState.States.Attack then return end

	local frame = self.state.frame
	local activeStart = move.startup + 1
	local activeEnd = move.startup + move.active
	local total = move.startup + move.active + move.recovery

	if frame >= activeStart and frame <= activeEnd then
		if self.root and self.root.Parent then
			local attackerPos = self.root.Position
			for _, victim in opponents do
				if victim ~= self and victim:isAlive() and not self.hitTargets[victim.player] then
					if hitboxService:Resolve(attackerPos, self.facing, move.hitbox, victim.character) then
						self.hitTargets[victim.player] = true
						onHit(self, victim)
					end
				end
			end
		end
	end

	if frame >= total then
		self.currentMove = nil
		self.state:set(FighterState.States.Idle)
	end
end

return FighterController
