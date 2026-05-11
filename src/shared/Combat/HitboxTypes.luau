export type HitboxShape = "Box" | "Sphere" | "Capsule"

export type Hitbox = {
	shape: HitboxShape,
	offset: Vector3,
	size: Vector3,
	startupFrame: number,
	activeFrames: number,
}

export type Hurtbox = {
	offset: Vector3,
	size: Vector3,
}

return {}
