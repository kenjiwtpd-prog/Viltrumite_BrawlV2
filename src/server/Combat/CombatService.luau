local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)
local Tuning = require(Shared.Config.Tuning)

local CombatService = {}
CombatService.fighters = {} :: { [Player]: { health: number, state: string } }

function CombatService:Start()
	-- Authoritative combat loop wired in a later step.
end

function CombatService:Register(plr: Player, maxHealth: number)
	self.fighters[plr] = { health = maxHealth, state = "Idle" }
end

function CombatService:ApplyDamage(victim: Player, attacker: Player, moveName: string, damage: number)
	local f = self.fighters[victim]
	if not f then return end
	local applied = damage * Tuning.GlobalDamageScale
	f.health = math.max(0, f.health - applied)
	Remotes.get("HitConfirmed"):FireAllClients({
		attackerId = attacker.UserId,
		victimId = victim.UserId,
		moveName = moveName,
		damage = applied,
	})
end

return CombatService
