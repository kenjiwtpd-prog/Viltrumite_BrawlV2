local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)

local CameraShake = {}
CameraShake.trauma = 0

function CameraShake:Add(amount: number) self.trauma = math.clamp(self.trauma + amount, 0, 1) end

function CameraShake:Start()
	Remotes.get("CameraShake").OnClientEvent:Connect(function(payload)
		self:Add(payload and payload.amount or 0.3)
	end)
	RunService.RenderStepped:Connect(function(dt)
		if self.trauma <= 0 then return end
		local cam = Workspace.CurrentCamera
		local mag = self.trauma * self.trauma
		local offset = CFrame.new(
			(math.random() - 0.5) * mag,
			(math.random() - 0.5) * mag,
			0
		)
		cam.CFrame = cam.CFrame * offset
		self.trauma = math.max(0, self.trauma - dt * 1.5)
	end)
end

return CameraShake
