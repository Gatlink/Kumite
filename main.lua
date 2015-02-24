require 'aphrodisiacs/utils/controls'
require 'gameObject'
require 'enemy'
require 'player'

local background
local playerObject, enemyObject

function love.load()
  love.window.setMode(800, 600)
  love.graphics.setBackgroundColor(255, 255, 255)

  background = love.graphics.newImage('assets/background.png')

	playerObject = Player
	-- enemyObject = Enemy.new(100, 200, playerObject)
end

function love.update(dt)
	playerObject:update(dt)
	-- enemyObject:update(dt)

	if Controls.isKeyPressed('escape') then
		love.event.push('quit')
		return
	elseif Controls.isKeyPressed(' ') then
		playerObject:hit()
	end

	Controls.update()
end

function love.draw()
  love.graphics.draw(background, 0, 0)
	playerObject:draw()
	-- enemyObject:draw()
end
