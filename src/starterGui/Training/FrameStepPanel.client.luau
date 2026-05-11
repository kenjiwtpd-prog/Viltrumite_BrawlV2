local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Debug = require(Shared.Config.Debug)

if not Debug.FrameStep then return end
-- Frame-step UI wired in a later step.
