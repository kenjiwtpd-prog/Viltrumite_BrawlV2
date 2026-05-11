local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)

local SFXService = {}

function SFXService:Start()
	Remotes.get("PlaySFX").OnClientEvent:Connect(function(payload)
		if not payload or not payload.soundId then return end
		local s = Instance.new("Sound")
		s.SoundId = payload.soundId
		s.Volume = payload.volume or 1
		s.Parent = SoundService
		s:Play()
		s.Ended:Connect(function() s:Destroy() end)
	end)
end

return SFXService
