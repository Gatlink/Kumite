require 'aphrodisiacs/utils/controls'
require 'gameObject'
require 'enemy'
require 'player'
require 'key'

local background
local playerObject, enemyObject

function love.load()
  math.randomseed(os.time())

  love.window.setMode(800, 600)
  love.graphics.setBackgroundColor(255, 255, 255)

  background = love.graphics.newImage('assets/background.png')

	playerObject = Player
	-- enemyObject = Enemy.new(100, 200, playerObject)

  Key.init(playerObject.pos.x, playerObject.pos.y - 90)
  Key.generateNewKeys(3)
end

function love.update(dt)
  if Controls.isKeyPressed('escape') then
		love.event.push('quit')
		return
  end

	playerObject:update(dt)
	-- enemyObject:update(dt)

  local currentKey = Key.getCurrent()
  if currentKey and Controls.isKeyPressed(currentKey:getDirection()) then
    playerObject:hit()
    Key.validateCurrent()
  end

  Key.updateAll(dt)

	Controls.update()
end

function love.draw()
  love.graphics.draw(background, 0, 0)
	playerObject:draw()
	-- enemyObject:draw()
  Key.drawAll()
end
