require './app/map.rb'
require './app/menu'
require './app/player.rb'

# Handles the game window as well as the game loop.
class ApplicationWindow < Gosu::Window

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480

  WINDOW_NAME = "Test"

  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = WINDOW_NAME
    @menu = Menu.new

    # TODO remove this flag and add a state machine.
    @in_menu = true

    @player = Player.new
    @map = Map.new
    @frames = 0
    @difficulty = 0
  end

  def update
    # TODO state machine.
    if @in_menu then
      @menu.update
    else
      @player.update
      @map.update
      # TODO move the map.colliding? and difficulty logic somewhere else.
      if @map.colliding? @player then
        @map.stop_moving!
        @player.die!
      end
      @frames += 1
      if @frames % 256 == 0
        @difficulty += 1
        @map.set_difficulty! @difficulty
      end
    end
  end

  def draw
    # TODO state machine.
    if @in_menu then
      @menu.draw
    else
      @player.draw
      @map.draw
    end
  end

  # Listens for global button presses.
  def button_down(button)
    if button == Gosu::KbEscape
      close
    end
  end
end

