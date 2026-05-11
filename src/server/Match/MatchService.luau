local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Remotes = require(Shared.Net.Remotes)
local Tuning = require(Shared.Config.Tuning)

local MatchService = {}
MatchService.state = "Idle"
MatchService.timer = 0

function MatchService:Start()
	-- Round/match flow wired in a later step.
end

function MatchService:SetState(state: string)
	self.state = state
	Remotes.get("MatchStateChanged"):FireAllClients({ state = state, time = Tuning.RoundTimeSeconds })
end

return MatchService
