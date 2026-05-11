local Combat = script.Parent.Parent
local DamageTypes = require(Combat.DamageTypes)

return {
	LightPunch = {
		name = "LightPunch",
		displayName = "Jab",
		damageType = DamageTypes.Light,
		damage = 4,
		startup = 4,
		active = 3,
		recovery = 8,
		hitstun = 12,
		blockstun = 6,
		knockback = Vector3.new(8, 0, 0),
		hitbox = { shape = "Box", offset = Vector3.new(2.5, 1.5, 0), size = Vector3.new(3, 2, 2), startupFrame = 4, activeFrames = 3 },
		properties = { cancelable = true, groundOk = true, airOk = true },
	},
}
