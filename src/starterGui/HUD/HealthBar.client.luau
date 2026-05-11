local Players = game:GetService("Players")

local plr = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "HealthBar"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 22)
frame.Position = UDim2.new(0, 24, 0, 24)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = gui

local fill = Instance.new("Frame")
fill.Size = UDim2.new(1, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
fill.BorderSizePixel = 0
fill.Parent = frame
