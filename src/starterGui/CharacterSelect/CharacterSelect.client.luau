local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Roster = require(Shared.Characters.Roster)
local Remotes = require(Shared.Net.Remotes)
local Packets = require(Shared.Net.Packets)

local plr = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "CharacterSelect"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.new(0.5, 0, 0.5, 0)
panel.Size = UDim2.new(0, 520, 0, 120)
panel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
panel.BackgroundTransparency = 0.2
panel.Parent = gui

local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 8)
layout.Parent = panel

for _, id in Roster.list() do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 110, 0, 90)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	btn.TextColor3 = Color3.fromRGB(240, 240, 240)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = Roster[id].displayName
	btn.Parent = panel
	btn.MouseButton1Click:Connect(function()
		Remotes.get("SelectCharacter"):FireServer(Packets.selectCharacter(id))
		gui.Enabled = false
	end)
end
