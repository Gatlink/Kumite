require 'gameObject'

local SCALEONHIT = 2
local SCALESPEEDONHIT = 10
local scale = 1

Player = GameObject.new(love.window.getWidth() / 2, love.window.getHeight() / 2, 'assets/mainAnimation.lua')

function Player:update(dt)
	scale = math.max(1, scale - SCALESPEEDONHIT * dt)

	GameObject.update(self, dt)
end

function Player:draw()
	GameObject.draw(self, scale)
end

function Player:hit()
	scale = SCALEONHIT
end
