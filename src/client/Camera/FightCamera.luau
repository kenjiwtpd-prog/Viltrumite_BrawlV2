local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local FightCamera = {}
FightCamera.enabled = false
FightCamera.targetZ = 25
FightCamera.height = 6

function FightCamera:Start()
	local cam = Workspace.CurrentCamera
	cam.CameraType = Enum.CameraType.Scriptable

	RunService.RenderStepped:Connect(function()
		local plr = Players.LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local focus = root.Position
		cam.CFrame = CFrame.new(focus.X, focus.Y + self.height, focus.Z + self.targetZ, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		cam.Focus = CFrame.new(focus)
	end)
end

return FightCamera
