local Players = game:GetService("Players")

local PlayerService = {}
PlayerService.profiles = {} :: { [Player]: any }

function PlayerService:Start()
	Players.PlayerAdded:Connect(function(plr) self:_onJoin(plr) end)
	Players.PlayerRemoving:Connect(function(plr) self:_onLeave(plr) end)
	for _, plr in Players:GetPlayers() do
		self:_onJoin(plr)
	end
end

function PlayerService:_onJoin(plr: Player)
	self.profiles[plr] = { selected = nil, wins = 0 }
end

function PlayerService:_onLeave(plr: Player)
	self.profiles[plr] = nil
end

return PlayerService
