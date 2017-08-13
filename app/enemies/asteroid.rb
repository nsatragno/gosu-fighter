require "./app/sprites"
require "./app/common/simple_collider"

# The most basic enemy.
class Asteroid
  include SimpleCollider

  # Default asteroid linear moving speed.
  SPEED = 30

  # Angle in rads the asteroid can shoot to.
  CONE = Math::PI / 4

  SPAWN_SIZE = 480

  ASTEROID_Z_ORDER = 9

  # The collision circle radius.
  ASTEROID_SIZE = 10

  ROTATIONAL_SPEED = Math::PI / 5

  CONE_AIM = Math::PI - CONE

  def initialize
    @sprite = Sprites::ASTEROID
    @x = ApplicationWindow::WINDOW_WIDTH
    @y = GlobalRandom::between(
      (ApplicationWindow::WINDOW_HEIGHT - SPAWN_SIZE) / 2,
      (ApplicationWindow::WINDOW_HEIGHT + SPAWN_SIZE) / 2)

    direction =
      GlobalRandom::rand_f * CONE + CONE_AIM * @y / ApplicationWindow::WINDOW_HEIGHT

    @dx = -Math::sin(direction)
    @dy = Math::cos(direction)

    @angle = 0
  end

  def update
    @x += @dx
    @y += @dy
    @angle += ROTATIONAL_SPEED
  end

  def draw
    @sprite.draw_rot @x, @y, ASTEROID_Z_ORDER, @angle
  end

  def collision_points
    [
      [@x + ASTEROID_SIZE / 1.41, @y + ASTEROID_SIZE / 1.41],
      [@x - ASTEROID_SIZE / 1.41, @y + ASTEROID_SIZE / 1.41],
      [@x + ASTEROID_SIZE / 1.41, @y - ASTEROID_SIZE / 1.41],
      [@x - ASTEROID_SIZE / 1.41, @y - ASTEROID_SIZE / 1.41],
      [@x + ASTEROID_SIZE, @y],
      [@x - ASTEROID_SIZE, @y],
      [@x, @y + ASTEROID_SIZE],
      [@x, @y - ASTEROID_SIZE],
    ]
  end
end
