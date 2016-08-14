require "./app/sprites.rb"

# The game player character.
class Player

  WIDTH = 30
  HEIGHT = 25

  # Up / Down movement speed.
  SPEED = 3

  PLAYER_Z_ORDER = 1

  attr_reader :top_aft, :bottom_aft, :nose

  def initialize
    @sprite = Sprites::PLAYER
    @pixel = Sprites::PIXEL

    # Top left coordinates.
    @x = 10
    @y = 320

    @top_aft = [@x + 5, @y]
    @bottom_aft = [@x + 5, @y + HEIGHT]
    @nose = [@x + WIDTH, @y + HEIGHT / 2]
  end

  def update
    delta = 0
    if Gosu::button_down? Gosu::KbW then
      delta -= 1
    end
    if Gosu::button_down? Gosu::KbS then
      delta += 1
    end

    @y += delta * SPEED
    @y = [@y, ApplicationWindow::WINDOW_HEIGHT - @sprite.height].min
    @y = [@y, 0].max
  end

  def draw
    @sprite.draw @x, @y, PLAYER_Z_ORDER
  end
end
