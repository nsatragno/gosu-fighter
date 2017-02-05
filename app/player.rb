require 'matrix'

require "./app/sprites"
require './app/bullets/linear_bullet.rb'

# The game player character.
class Player

  WIDTH = 30
  HEIGHT = 25

  # Up / Down movement speed.
  STARTING_SPEED = 4

  BULLET_SPEED = 6

  PLAYER_Z_ORDER = 10

  DEFAULT_COLOR = 0xff_ffffff

  LIFES = 5

  CURRENT_FRAME = 0

  def initialize
    @sprite = Sprites::PLAYER
    @pixel = Sprites::PIXEL

    @current_frame = CURRENT_FRAME

    @state = :alive
    @color = DEFAULT_COLOR

    @lifes = LIFES

    @speed = STARTING_SPEED

    # Top left coordinates.
    @x = 10
    @y = 320
  end

  def collision_points
    [@top_aft, @bottom_aft, @nose]
  end

  def remove_life
    if @state != :inmune
      @lifes -= 1 if @lifes > 0
      @state = :inmune
      die! if @lifes == 0
    end
  end

  def die!
    @color = DEAD_COLOR
    @state = :dead
  end

  def lifes
    return @lifes.to_s
  end

  def fire!(x, y)
    return if @state == :dead
    LinearBullet.new @x, @y, *Vector[x - @x, y - @y].normalize * BULLET_SPEED
  end

  def update
    case @state
    when :dead
      @color -= 100 if @color > 0
    when :alive
      delta = 0
      if Gosu::button_down? Gosu::KbW then
        delta -= 1
      end
      if Gosu::button_down? Gosu::KbS then
        delta += 1
      end

      @y += delta * @speed
      @y = [@y, ApplicationWindow::WINDOW_HEIGHT - @sprite.height].min
      @y = [@y, 0].max

      recalculate_collision_points!
    when :inmune
      # do the same as being alive
      delta = 0
      if Gosu::button_down? Gosu::KbW then
        delta -= 1
      end
      if Gosu::button_down? Gosu::KbS then
        delta += 1
      end

      @y += delta * @speed
      @y = [@y, ApplicationWindow::WINDOW_HEIGHT - @sprite.height].min
      @y = [@y, 0].max

      recalculate_collision_points!

      # but being inmune for 2 seconds @60fps
      @color -= 100 if @color > 0
      if @current_frame < 120
        @current_frame += 1
      else
        @state = :alive
        @current_frame = 0
      end
    end
  end

  def draw
    @sprite.draw @x, @y, PLAYER_Z_ORDER, 1, 1, @color
  end

  private
  def recalculate_collision_points!
    @top_aft = [@x + 5, @y]
    @bottom_aft = [@x + 5, @y + HEIGHT]
    @nose = [@x + WIDTH, @y + HEIGHT / 2]
  end
end
