require 'animlove'

GameObject = {}
GameObject.__index = GameObject

function GameObject.new(x, y, animFile, imgFile)
	local new = {
		x = x,
		y = y,
		sprite = LoveAnimation.new(animFile, imgFile)
	}

	new.sprite.relativeOriginX = 0.5
	new.sprite.relativeOriginY = 0.5

	setmetatable(new, GameObject)
	return new
end

function GameObject:update(dt)
	self.sprite:setPosition(self.x, self.y)
	self.sprite:update(dt)
end

function GameObject:draw(scale)
	scale = scale or 1

	self.sprite:draw(scale, scale)
end
