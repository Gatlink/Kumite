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
		if self.x > self.target.x then
			self.sprite:setHorizontalFlip(false)
			self.x = math.max(self.x - SPEED * dt, self.target.x + XDISTANCE)
		else
			self.sprite:setHorizontalFlip(true)
			self.x = math.min(self.x + SPEED * dt, self.target.x - XDISTANCE)
		end

		if self.y > self.target.y then
			self.y = math.max(self.y - SPEED * dt, self.target.y)
		else
			self.y = math.min(self.y + SPEED * dt, self.target.y)
		end
	end

	if math.abs(self.x - self.target.x) == XDISTANCE and self.y == self.target.y then
		self.state = EnemyState.Idle
	end

	GameObject.update(self, dt)
end
