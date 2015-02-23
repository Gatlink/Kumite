require 'gameObject'

Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, GameObject)

EnemyState = {
	Approaching = 0,
	Idle = 1
}

local SPEED = 50
local XDISTANCE = 128

function Enemy.new(x, y, player)
	local new = GameObject.new(x, y, 'assets/mainAnimation.lua', 'assets/enemy.png')
	new.state = EnemyState.Approaching
	new.target = player

	setmetatable(new, Enemy)
	return new
end

function Enemy:update(dt)
	if self.state == EnemyState.Approaching then
		if self.pos.x > self.target.pos.x then
			self.sprite:setHorizontalFlip(false)
			self.pos.x = math.max(self.pos.x - SPEED * dt, self.target.pos.x + XDISTANCE)
		else
			self.sprite:setHorizontalFlip(true)
			self.pos.x = math.min(self.pos.x + SPEED * dt, self.target.pos.x - XDISTANCE)
		end

		if self.pos.y > self.target.pos.y then
			self.pos.y = math.max(self.pos.y - SPEED * dt, self.target.pos.y)
		else
			self.pos.y = math.min(self.pos.y + SPEED * dt, self.target.pos.y)
		end
	end

	if math.abs(self.pos.x - self.target.pos.x) == XDISTANCE and self.pos.y == self.target.pos.y then
		self.state = EnemyState.Idle
	end

	GameObject.update(self, dt)
end
