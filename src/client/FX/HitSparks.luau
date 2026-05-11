local HitSparks = {}

function HitSparks.spawn(position: Vector3)
	local part = Instance.new("Part")
	part.Anchored = true
	part.CanCollide = false
	part.Size = Vector3.new(0.6, 0.6, 0.6)
	part.Material = Enum.Material.Neon
	part.Color = Color3.fromRGB(255, 220, 120)
	part.Position = position
	part.Parent = workspace
	game:GetService("Debris"):AddItem(part, 0.15)
end

return HitSparks
