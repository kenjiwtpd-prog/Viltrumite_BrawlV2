local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ComboCounter"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 200, 0, 60)
label.Position = UDim2.new(0, 24, 0, 60)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBlack
label.TextSize = 36
label.TextColor3 = Color3.fromRGB(255, 220, 80)
label.TextStrokeTransparency = 0
label.TextXAlignment = Enum.TextXAlignment.Left
label.Text = ""
label.Parent = gui
