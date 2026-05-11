local Workspace = game:GetService("Workspace")

local SpawnService = {}

function SpawnService:Start()
	self.spawns = Workspace:FindFirstChild("SpawnPoints")
end

function SpawnService:GetSpawn(index: number): CFrame
	if self.spawns then
		local children = self.spawns:GetChildren()
		local pt = children[((index - 1) % math.max(1, #children)) + 1]
		if pt and pt:IsA("BasePart") then return pt.CFrame end
	end
	local x = (index == 1) and -10 or 10
	return CFrame.new(x, 5, 0)
end

return SpawnService
