require 'gameObject'

local spriteSize = 32
local keyStartX
local keyY
local all = {}

KeyDirection = {
  up = 0,
  right = 1,
  down = 2,
  left = 3
}

Key = {}
Key.__index = Key
setmetatable(Key, GameObject)

function Key.new(direction)
  local new = GameObject.new(keyStartX + #all * (spriteSize + 5), keyY, 'assets/arrowAnimation.lua')
  new.direction = direction

  new.sprite:setRotation(direction * math.pi / 2)

  setmetatable(new, Key)
  return new
end

function Key.init(startX, y)
  keyStartX = startX
  keyY = y
end

function Key.getCurrent()
  return all[1]
end

function Key.generateNewKeys(count)
  count = count or 1

  for i=1,count do
    table.insert(all, Key.new(math.random(0, 3)))
  end
end

function Key.updateAll(dt)
  if #all == 0 then
    Key.generateNewKeys(3)
  end
end

function Key.drawAll()
  for _, key in ipairs(all) do
    key:draw()
  end
end

function Key.validateCurrent()
  table.remove(all, 1)
end

function Key:getDirection()
  for k, v in pairs(KeyDirection) do
    if self.direction == v then
      return k
    end
  end
end
