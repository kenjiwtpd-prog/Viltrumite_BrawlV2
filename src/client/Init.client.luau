local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)

Remotes.init()

local clientFolder = script.Parent

local function load(modName: string)
	local mod = clientFolder:FindFirstChild(modName, true)
	if mod and mod:IsA("ModuleScript") then
		local ok, svc = pcall(require, mod)
		if ok and type(svc) == "table" and svc.Start then
			svc:Start()
		end
	end
end

load("InputService")
load("AnimationService")
load("FightCamera")
load("CameraShake")
load("VFXService")
load("SFXService")
load("HitConfirm")

print("[Client] Boot complete.")
