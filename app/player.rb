require 'matrix'

require "./app/sprites"
require './app/bullets/linear_bullet.rb'

# The game player character.
class Player
  attr_reader :lifes

  WIDTH = 30
  HEIGHT = 25

  # Up / Down movement speed.
  STARTING_SPEED = 3

  BULLET_SPEED = 6

  PLAYER_Z_ORDER = 10

  DEFAULT_COLOR = 0xff_ffffff

  STARTING_LIFES = 5

  def initialize
    @sprite = Sprites::PLAYER
    @pixel = Sprites::PIXEL

    @state = :alive
    @color = DEFAULT_COLOR
    @immunity_frame = 0

    @lifes = STARTING_LIFES

    @lives = LIVES

    @speed = STARTING_SPEED

    # Top left coordinates.
    @x = 10
    @y = 320
  end

  def collision_points
    [@top_aft, @bottom_aft, @nose]
  end

<<<<<<< HEAD
  def remove_life!
    if @state != :immune
      @lifes -= 1
      die! if @lifes == 0
      @state = :immune
    end
=======
  def remove_life
    @lives -= 1 if @lives > 1
    inmune_time 3
    die! if @lives == 0
>>>>>>> working on player and enemy classes, not working at this state
  end

  def die!
    @state = :dead
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
      move
    when :immune
      move

      @color -= 100 if @color > 0
      if @immunity_frame < 120
        @immunity_frame += 1
      else
        @state = :alive
        @immunity_frame = 0
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

  private
  def move
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
  end

end
