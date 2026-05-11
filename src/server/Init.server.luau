local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)

Remotes.init()

local serverFolder = script.Parent

local function load(modName: string)
	local mod = serverFolder:FindFirstChild(modName, true)
	if mod and mod:IsA("ModuleScript") then
		local ok, svc = pcall(require, mod)
		if ok and type(svc) == "table" and svc.Start then
			svc:Start()
		end
	end
end

load("PlayerService")
load("SelectionService")
load("MatchService")
load("CombatService")
load("HitboxService")
load("GrabService")
load("UltService")
load("SpawnService")

print("[Server] Boot complete.")
