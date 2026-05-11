local Math2D = {}

function Math2D.facingFromTo(a: Vector3, b: Vector3): number
	return (b.X - a.X) >= 0 and 1 or -1
end

function Math2D.flipOffset(offset: Vector3, facing: number): Vector3
	return Vector3.new(offset.X * facing, offset.Y, offset.Z)
end

function Math2D.lockToPlane(pos: Vector3, planeZ: number): Vector3
	return Vector3.new(pos.X, pos.Y, planeZ)
end

return Math2D
