local DEFAULT_WINDOW = 8

local InputBuffer = {}
InputBuffer.__index = InputBuffer

function InputBuffer.new(window: number?)
	return setmetatable({ window = window or DEFAULT_WINDOW, entries = {} }, InputBuffer)
end

function InputBuffer:push(action: string, frame: number)
	table.insert(self.entries, { action = action, frame = frame })
	while #self.entries > 32 do
		table.remove(self.entries, 1)
	end
end

function InputBuffer:has(action: string, currentFrame: number): boolean
	for i = #self.entries, 1, -1 do
		local e = self.entries[i]
		if currentFrame - e.frame > self.window then return false end
		if e.action == action then return true end
	end
	return false
end

function InputBuffer:consume(action: string, currentFrame: number): boolean
	for i = #self.entries, 1, -1 do
		local e = self.entries[i]
		if currentFrame - e.frame > self.window then return false end
		if e.action == action then
			table.remove(self.entries, i)
			return true
		end
	end
	return false
end

return InputBuffer
