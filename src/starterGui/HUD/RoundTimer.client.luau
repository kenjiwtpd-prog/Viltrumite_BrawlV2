local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RoundTimer"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 120, 0, 48)
label.AnchorPoint = Vector2.new(0.5, 0)
label.Position = UDim2.new(0.5, 0, 0, 16)
label.BackgroundTransparency = 0.4
label.BackgroundColor3 = Color3.new(0, 0, 0)
label.Font = Enum.Font.GothamBlack
label.TextSize = 32
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Text = "99"
label.Parent = gui
