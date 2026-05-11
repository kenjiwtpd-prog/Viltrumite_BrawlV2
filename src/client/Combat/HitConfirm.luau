local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)
local CameraShake = require(script.Parent.Parent.Camera.CameraShake)
local HitSparks = require(script.Parent.Parent.FX.HitSparks)

local HitConfirm = {}

function HitConfirm:Start()
	Remotes.get("HitConfirmed").OnClientEvent:Connect(function(payload)
		CameraShake:Add(math.clamp(payload.damage / 50, 0.1, 0.6))
		local victim = Players:GetPlayerByUserId(payload.victimId)
		local char = victim and victim.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then HitSparks.spawn(root.Position) end
	end)
end

return HitConfirm
