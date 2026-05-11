local Enum_ = Enum

return {
	MoveLeft  = { Enum_.KeyCode.A, Enum_.KeyCode.Left },
	MoveRight = { Enum_.KeyCode.D, Enum_.KeyCode.Right },
	Jump      = { Enum_.KeyCode.W, Enum_.KeyCode.Space },
	Crouch    = { Enum_.KeyCode.S, Enum_.KeyCode.Down },
	LightAttack = { Enum_.KeyCode.J },
	HeavyAttack = { Enum_.KeyCode.K },
	Grab        = { Enum_.KeyCode.L },
	Block       = { Enum_.KeyCode.U },
	Dash        = { Enum_.KeyCode.LeftShift },
	Ult         = { Enum_.KeyCode.I },
}
