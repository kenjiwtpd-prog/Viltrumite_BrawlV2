local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)

local VFXService = {}

function VFXService:Start()
	Remotes.get("PlayVFX").OnClientEvent:Connect(function(payload)
		-- payload: { name, position, duration }
		-- Spawn FX templates here in a later step.
	end)
end

return VFXService
