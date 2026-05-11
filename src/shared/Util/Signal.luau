local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({ _handlers = {} }, Signal)
end

function Signal:Connect(fn)
	table.insert(self._handlers, fn)
	local handlers = self._handlers
	return {
		Disconnect = function()
			for i, h in handlers do
				if h == fn then table.remove(handlers, i) break end
			end
		end,
	}
end

function Signal:Fire(...)
	for _, h in self._handlers do
		task.spawn(h, ...)
	end
end

function Signal:Destroy()
	self._handlers = {}
end

return Signal
