local States = {
	Idle = "Idle",
	Walk = "Walk",
	Dash = "Dash",
	Jump = "Jump",
	Air = "Air",
	Attack = "Attack",
	Block = "Block",
	Hitstun = "Hitstun",
	Blockstun = "Blockstun",
	Knockdown = "Knockdown",
	GetUp = "GetUp",
	Grab = "Grab",
	Grabbed = "Grabbed",
	Ult = "Ult",
	KO = "KO",
}

local FighterState = {}
FighterState.States = States
FighterState.__index = FighterState

local TRANSITIONS = {
	[States.Idle]    = { Walk=true, Dash=true, Jump=true, Attack=true, Block=true, Grab=true, Ult=true, Hitstun=true, Grabbed=true },
	[States.Walk]    = { Idle=true, Dash=true, Jump=true, Attack=true, Block=true, Grab=true, Ult=true, Hitstun=true, Grabbed=true },
	[States.Dash]    = { Idle=true, Attack=true, Jump=true, Hitstun=true, Grabbed=true },
	[States.Jump]    = { Air=true, Attack=true, Hitstun=true },
	[States.Air]     = { Idle=true, Attack=true, Hitstun=true },
	[States.Attack]  = { Idle=true, Attack=true, Hitstun=true, Grabbed=true },
	[States.Block]   = { Idle=true, Blockstun=true, Hitstun=true, Grabbed=true },
	[States.Hitstun] = { Idle=true, Knockdown=true, Air=true },
	[States.Blockstun] = { Idle=true, Block=true },
	[States.Knockdown] = { GetUp=true },
	[States.GetUp]   = { Idle=true },
	[States.Grab]    = { Idle=true, Attack=true },
	[States.Grabbed] = { Idle=true, Hitstun=true, Knockdown=true },
	[States.Ult]     = { Idle=true },
	[States.KO]      = {},
}

function FighterState.new()
	return setmetatable({ current = States.Idle, frame = 0 }, FighterState)
end

function FighterState:canTransition(to: string): boolean
	local allowed = TRANSITIONS[self.current]
	return allowed ~= nil and allowed[to] == true
end

function FighterState:set(to: string): boolean
	if self.current == to then return true end
	if not self:canTransition(to) then return false end
	self.current = to
	self.frame = 0
	return true
end

function FighterState:tick()
	self.frame += 1
end

return FighterState
