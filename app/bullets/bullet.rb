class Bullet
  BULLET_Z_INDEX = 3
  BULLET_SIZE = 5

  attr_reader :x, :y

  def collision_points
    [[@x, @y]]
  end

  def draw
    @sprite.draw @x, @y, BULLET_Z_INDEX,
                 BULLET_SIZE, BULLET_SIZE, @color
  end

  protected

  def initialize(x, y)
    @x = x
    @y = y
    @sprite = Sprites::PIXEL
    @color = 0xff_ff00ff
  end
end
