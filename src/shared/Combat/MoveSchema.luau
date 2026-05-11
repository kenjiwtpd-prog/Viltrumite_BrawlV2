local HitboxTypes = require(script.Parent.HitboxTypes)
local DamageTypes = require(script.Parent.DamageTypes)

export type MoveProperties = {
	cancelable: boolean?,
	armor: boolean?,
	invuln: boolean?,
	airOk: boolean?,
	groundOk: boolean?,
}

export type MoveDef = {
	name: string,
	displayName: string,
	damageType: DamageTypes.DamageType,
	damage: number,
	startup: number,
	active: number,
	recovery: number,
	hitstun: number,
	blockstun: number,
	knockback: Vector3,
	hitbox: HitboxTypes.Hitbox,
	animation: string?,
	sound: string?,
	properties: MoveProperties?,
}

local MoveSchema = {}

function MoveSchema.validate(move: MoveDef): (boolean, string?)
	if type(move.name) ~= "string" then return false, "missing name" end
	if type(move.damage) ~= "number" then return false, "missing damage" end
	if type(move.startup) ~= "number" then return false, "missing startup" end
	if type(move.active) ~= "number" then return false, "missing active" end
	if type(move.recovery) ~= "number" then return false, "missing recovery" end
	if move.hitbox == nil then return false, "missing hitbox" end
	return true, nil
end

return MoveSchema
