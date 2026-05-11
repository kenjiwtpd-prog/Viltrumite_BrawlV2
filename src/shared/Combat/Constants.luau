local Constants = {
	FPS = 60,
	FrameTime = 1 / 60,
	StageHalfWidth = 60,
	StageDepth = 4,
	FacingRight = 1,
	FacingLeft = -1,
}

function Constants.framesToSeconds(frames: number): number
	return frames * Constants.FrameTime
end

return Constants
