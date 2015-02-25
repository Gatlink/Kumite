require 'aphrodisiacs/love-animation/animlove'
require 'aphrodisiacs/utils/vector'

GameObject = {}
GameObject.__index = GameObject

function GameObject.new(x, y, animFile, imgFile)
	local new = {
		pos = Vector.new(x, y),
		sprite = LoveAnimation.new(animFile, imgFile)
	}

	new.sprite.relativeOriginX = 0.5
	new.sprite.relativeOriginY = 0.5
  new.sprite:setPosition(new.pos.x, new.pos.y)

	setmetatable(new, GameObject)
	return new
end

function GameObject:update(dt)
	self.sprite:setPosition(self.pos.x, self.pos.y)
	self.sprite:update(dt)
end

function GameObject:draw(scale)
	scale = scale or 1

	self.sprite:draw(scale, scale)
end
