require "./app/sprites.rb"

# The game player character.
class Player

  # Up / Down movement speed.
  SPEED = 3

  PLAYER_Z_ORDER = 1

  def initialize
    @sprite = Sprites::PLAYER

    # TODO Remove this magic numbers.
    @x = 10
    @y = 320
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
