local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REMOTE_NAMES = {
	"InputCommand",
	"SelectCharacter",
	"MatchStateChanged",
	"FighterStateChanged",
	"HitConfirmed",
	"PlayVFX",
	"PlaySFX",
	"CameraShake",
}

local Remotes = {}
local cache: { [string]: RemoteEvent } = {}

local function folder(): Folder
	local existing = ReplicatedStorage:FindFirstChild("Remotes")
	if existing then return existing end
	if RunService:IsServer() then
		local f = Instance.new("Folder")
		f.Name = "Remotes"
		f.Parent = ReplicatedStorage
		return f
	end
	return ReplicatedStorage:WaitForChild("Remotes")
end

function Remotes.init()
	local f = folder()
	if RunService:IsServer() then
		for _, name in REMOTE_NAMES do
			if not f:FindFirstChild(name) then
				local r = Instance.new("RemoteEvent")
				r.Name = name
				r.Parent = f
			end
		end
	end
end

function Remotes.get(name: string): RemoteEvent
	if cache[name] then return cache[name] end
	local f = folder()
	local r = f:WaitForChild(name)
	cache[name] = r
	return r
end

return Remotes
