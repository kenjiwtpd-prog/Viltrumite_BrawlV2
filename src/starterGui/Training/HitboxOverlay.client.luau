local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage:WaitForChild("Shared"))
local Debug = require(Shared.Config.Debug)

if not Debug.ShowHitboxes then return end
-- Hitbox overlay rendering wired in a later step.
