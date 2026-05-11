local HitboxService = {}

function HitboxService:Start() end

function HitboxService:Resolve(attackerCF: CFrame, hitbox, victimChar: Model): boolean
	if not victimChar or not victimChar.PrimaryPart then return false end
	local hbCF = attackerCF * CFrame.new(hitbox.offset)
	local victimPos = victimChar.PrimaryPart.Position
	local rel = hbCF:PointToObjectSpace(victimPos)
	local h = hitbox.size / 2
	return math.abs(rel.X) <= h.X and math.abs(rel.Y) <= h.Y and math.abs(rel.Z) <= h.Z
end

return HitboxService
