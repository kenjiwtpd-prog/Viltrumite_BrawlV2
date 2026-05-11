local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)
local Roster = require(Shared.Characters.Roster)

local SelectionService = {}
SelectionService.selections = {} :: { [Player]: string }

function SelectionService:Start()
	Remotes.get("SelectCharacter").OnServerEvent:Connect(function(plr, payload)
		local id = payload and payload.characterId
		if type(id) == "string" and Roster[id] then
			self.selections[plr] = id
		end
	end)
end

function SelectionService:Get(plr: Player): string?
	return self.selections[plr]
end

return SelectionService
