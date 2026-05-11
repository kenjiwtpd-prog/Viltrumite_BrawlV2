local Maid = {}
Maid.__index = Maid

function Maid.new()
	return setmetatable({ _tasks = {} }, Maid)
end

function Maid:Give(t)
	table.insert(self._tasks, t)
	return t
end

function Maid:Clean()
	for _, t in self._tasks do
		if typeof(t) == "RBXScriptConnection" then
			t:Disconnect()
		elseif typeof(t) == "Instance" then
			t:Destroy()
		elseif type(t) == "function" then
			t()
		elseif type(t) == "table" and t.Disconnect then
			t:Disconnect()
		elseif type(t) == "table" and t.Destroy then
			t:Destroy()
		end
	end
	self._tasks = {}
end

return Maid
