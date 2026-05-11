local AnimationService = {}
AnimationService.tracks = {} :: { [string]: AnimationTrack }

function AnimationService:Start() end

function AnimationService:Play(humanoid: Humanoid, animId: string)
	if not humanoid then return end
	local anim = Instance.new("Animation")
	anim.AnimationId = animId
	local track = humanoid:LoadAnimation(anim)
	track:Play()
	return track
end

return AnimationService
