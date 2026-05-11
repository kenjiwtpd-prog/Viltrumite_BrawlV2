local HitboxService = {}

function HitboxService:Start() end

function HitboxService:Resolve(attackerPos: Vector3, facing: number, hitbox, victimChar: Model): boolean
	if not victimChar or not victimChar.PrimaryPart then return false end
	local center = attackerPos + Vector3.new(hitbox.offset.X * facing, hitbox.offset.Y, hitbox.offset.Z)
	local victimPos = victimChar.PrimaryPart.Position
	local rel = victimPos - center
	local h = hitbox.size / 2
	return math.abs(rel.X) <= h.X and math.abs(rel.Y) <= h.Y and math.abs(rel.Z) <= h.Z
end

return HitboxService
