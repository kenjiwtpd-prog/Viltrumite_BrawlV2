local Combat = script.Parent.Parent
local DamageTypes = require(Combat.DamageTypes)

return {
	LightPunch = {
		name = "LightPunch",
		displayName = "Claw",
		damageType = DamageTypes.Light,
		damage = 5,
		startup = 5,
		active = 3,
		recovery = 9,
		hitstun = 13,
		blockstun = 7,
		knockback = Vector3.new(9, 0, 0),
		hitbox = { shape = "Box", offset = Vector3.new(2.7, 1.5, 0), size = Vector3.new(3.2, 2, 2), startupFrame = 5, activeFrames = 3 },
		properties = { cancelable = true, groundOk = true },
	},
}
