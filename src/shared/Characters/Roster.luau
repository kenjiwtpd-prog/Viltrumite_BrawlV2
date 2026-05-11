local Roster = {
	Conquest = {
		id = "Conquest",
		displayName = "Conquest",
		maxHealth = 110,
		walkSpeed = 15,
		dashSpeed = 40,
		jumpPower = 50,
		weight = 1.1,
		movesetModule = "Conquest",
	},
	Nolan = {
		id = "Nolan",
		displayName = "Omni-Man",
		maxHealth = 105,
		walkSpeed = 16,
		dashSpeed = 44,
		jumpPower = 52,
		weight = 1.05,
		movesetModule = "Nolan",
	},
	Battlebeast = {
		id = "Battlebeast",
		displayName = "Battle Beast",
		maxHealth = 120,
		walkSpeed = 14,
		dashSpeed = 38,
		jumpPower = 48,
		weight = 1.2,
		movesetModule = "Battlebeast",
	},
	Mark = {
		id = "Mark",
		displayName = "Invincible",
		maxHealth = 100,
		walkSpeed = 17,
		dashSpeed = 46,
		jumpPower = 54,
		weight = 1.0,
		movesetModule = "Mark",
	},
}

function Roster.list(): { string }
	local out = {}
	for id in pairs(Roster) do
		if type(Roster[id]) == "table" then
			table.insert(out, id)
		end
	end
	table.sort(out)
	return out
end

return Roster
