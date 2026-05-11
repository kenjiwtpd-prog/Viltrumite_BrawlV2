local Constants = require(script.Parent.Constants)

local FrameData = {}

function FrameData.totalFrames(move): number
	return move.startup + move.active + move.recovery
end

function FrameData.activeWindow(move): (number, number)
	return move.startup + 1, move.startup + move.active
end

function FrameData.totalSeconds(move): number
	return FrameData.totalFrames(move) * Constants.FrameTime
end

return FrameData
