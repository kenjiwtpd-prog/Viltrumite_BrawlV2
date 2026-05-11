local UltService = {}
UltService.meters = {} :: { [Player]: number }

function UltService:Start() end

function UltService:Add(plr: Player, amount: number)
	self.meters[plr] = math.clamp((self.meters[plr] or 0) + amount, 0, 100)
end

function UltService:CanFire(plr: Player): boolean
	return (self.meters[plr] or 0) >= 100
end

function UltService:Consume(plr: Player)
	self.meters[plr] = 0
end

return UltService
