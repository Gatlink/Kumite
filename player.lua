require 'gameObject'

local SCALEONHIT = 1.5
local SCALEDURATIONONHIT = 0.5
local scale = 1

Player = GameObject.new(500, 500, 'assets/mainAnimation.lua')
Player.sprite:setHorizontalFlip(true)

function Player:update(dt)
	scale = math.max(1, scale - SCALEONHIT * dt / SCALEDURATIONONHIT)

	GameObject.update(self, dt)
end

function Player:draw()
	GameObject.draw(self, scale)
end

function Player:hit()
	scale = SCALEONHIT
end
