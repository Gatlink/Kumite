require 'gameObject'
require 'enemy'
require 'player'

local playerObject, enemyObject

function love.load()
	love.graphics.setBackgroundColor(182, 202, 182)
	love.window.setMode(800, 600)

	playerObject = Player
	enemyObject = Enemy.new(100, 200, playerObject)
end

function love.update(dt)
	playerObject:update(dt)
	enemyObject:update(dt)
end

function love.draw()
	playerObject:draw()
	enemyObject:draw()
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.push('quit')
	elseif key == ' ' then
		playerObject:hit()
	end
end
