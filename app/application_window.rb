require './app/map.rb'
require './app/player.rb'

# Handles the game window as well as the game loop.
class ApplicationWindow < Gosu::Window

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480

  WINDOW_NAME = "Test"

  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = WINDOW_NAME
    @player = Player.new
    @map = Map.new
  end

  def update
    @player.update
    @map.update
    if @map.colliding? @player then
      @map.stop_moving!
      @player.die!
    end
  end

  def draw
    @player.draw
    @map.draw
  end

  # Listens for global button presses.
  def button_down(button)
    if button == Gosu::KbEscape
      close
    end
  end
end

