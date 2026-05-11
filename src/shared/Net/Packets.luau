local Packets = {}

function Packets.inputCommand(action: string, pressed: boolean, frame: number)
	return { action = action, pressed = pressed, frame = frame }
end

function Packets.selectCharacter(characterId: string)
	return { characterId = characterId }
end

function Packets.hitConfirmed(attackerId: number, victimId: number, moveName: string, damage: number)
	return { attackerId = attackerId, victimId = victimId, moveName = moveName, damage = damage }
end

return Packets
