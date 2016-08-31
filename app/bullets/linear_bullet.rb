require './app/bullets/bullet.rb'

class LinearBullet < Bullet
  def initialize(x, y, dx, dy)
    super x, y
    @dx = dx
    @dy = dy
  end

  def update
    @x += @dx
    @y += @dy
  end
end
