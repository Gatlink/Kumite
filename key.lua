require 'gameObject'
require 'aphrodisiacs/utils/mathExtension'

local INVALIDLIFESPAN = 0.25
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

KeyColors = {}
KeyColors[KeyDirection.up] = {188, 188, 48}
KeyColors[KeyDirection.right] = {67, 207, 67}
KeyColors[KeyDirection.down] = {67, 67, 207}
KeyColors[KeyDirection.left] = {188, 48, 188}

Key = {}
Key.__index = Key
setmetatable(Key, GameObject)

function Key.new(direction)
  local new = GameObject.new(0, 0, 'assets/arrowAnimation.lua')
  new.direction = direction
  new.invalid = false
  new.pos:set(love.window.getWidth() + spriteSize, keyY)

  new.sprite:setRotation(direction * math.pi / 2)

  setmetatable(new, Key)
  return new
end

function Key.getDirections()
  local dir = {}
  for k, _ in pairs(KeyDirection) do
    table.insert(dir, k)
  end
  return dir
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
    Key.computeKeyPositions(1)
  end

  Key.computeKeyPositions(dt)

  local cleanedAll = {}
  for _, key in ipairs(all) do
    key:update(dt)

    if not key.invalid or key.lifeSpan > 0 then
      table.insert(cleanedAll, key)
    end
  end
  all = cleanedAll
end

function Key.drawAll()
  for _, item in ipairs(all) do
    love.graphics.setColor(item.invalid and {0, 0, 0} or KeyColors[item.direction])
    item:draw()
  end
end

function Key.validateCurrent()
  table.remove(all, 1)
end

function Key.invalidateCurrent()
  all[1].invalid = true
  all[1].lifeSpan = INVALIDLIFESPAN
end

function Key.computeKeyPositions(dt)
  local totalLength = #all * spriteSize + (#all - 1) * 5
  for i, key in ipairs(all) do
    local newX = keyStartX - totalLength * 0.5 + (i - 1) * (spriteSize + 5)
    local ratio = math.max(newX > key.pos.x and key.pos.x / newX or newX / key.pos.x, 0.1)
    key.pos.x = math.lerp(key.pos.x, newX, math.pow(ratio, 2))
    key.pos.y = keyY

    if key.invalid then
      key.pos.x = math.lerp(newX - 1, newX + 1, math.sin(math.exp(20 + key.lifeSpan)))
      -- key.pos.y = math.lerp(keyY - 3, keyY + 10, math.pow(key.lifeSpan / INVALIDLIFESPAN, 2))
    end
  end
end

function Key:update(dt)
  GameObject.update(self, dt)

  if self.invalid then
    self.lifeSpan = self.lifeSpan - dt
  end
end

function Key:getDirection()
  for k, v in pairs(KeyDirection) do
    if self.direction == v then
      return k
    end
  end
end
