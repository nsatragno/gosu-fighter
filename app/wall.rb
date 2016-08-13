# Models a piece of the polygon wall.
class Wall

  attr_reader :point1
  attr_reader :point2

  # The wall thickness
  WIDTH = 5

  WALL_Z_ORDER = 2

  COLOR = 0xff_ff0000

  # Constructs the wall with the given points.
  def initialize(point1, point2)
    @sprite = Sprites::WALL
    @point1 = point1
    @point2 = point2
  end

  def draw
    @sprite.draw_as_quad point1[0], point1[1], COLOR,
                         point1[0], point1[1] + WIDTH, COLOR,
                         point2[0], point2[1], COLOR,
                         point2[0], point2[1] + WIDTH, COLOR,
                         WALL_Z_ORDER
  end
end
