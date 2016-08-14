# Models a piece of the polygon wall.
class Wall

  attr_reader :point1
  attr_reader :point2

  attr_writer :color

  # The wall thickness
  WIDTH = 5

  WALL_Z_ORDER = 2

  DEFAULT_COLOR = 0xff_ff0000

  # Constructs the wall with the given points.
  def initialize(point1, point2)
    @sprite = Sprites::WALL
    @point1 = point1
    @point2 = point2
    @color = DEFAULT_COLOR
  end

  def draw
    @sprite.draw_as_quad point1[0], point1[1], @color,
                         point1[0], point1[1] + WIDTH, @color,
                         point2[0], point2[1], @color,
                         point2[0], point2[1] + WIDTH, @color,
                         WALL_Z_ORDER
  end

  def x_length
    @point2[0] - @point1[0]
  end

  def y_length
    @point2[1] - @point1[1]
  end
end
