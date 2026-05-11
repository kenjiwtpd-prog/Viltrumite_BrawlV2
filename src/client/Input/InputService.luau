local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)
local Packets = require(Shared.Net.Packets)
local KeyMap = require(script.Parent.KeyMap)

local InputService = {}
local frame = 0

local function actionForKey(key: Enum.KeyCode): string?
	for action, keys in KeyMap do
		for _, k in keys do
			if k == key then return action end
		end
	end
	return nil
end

function InputService:Start()
	UIS.InputBegan:Connect(function(input, processed)
		if processed then return end
		local action = actionForKey(input.KeyCode)
		if action then
			Remotes.get("InputCommand"):FireServer(Packets.inputCommand(action, true, frame))
		end
	end)
	UIS.InputEnded:Connect(function(input, processed)
		if processed then return end
		local action = actionForKey(input.KeyCode)
		if action then
			Remotes.get("InputCommand"):FireServer(Packets.inputCommand(action, false, frame))
		end
	end)
	game:GetService("RunService").Heartbeat:Connect(function() frame += 1 end)
end

return InputService
