require './app/game.rb'
require './app/menu'

# Handles the game window and owns the current state, delegating update, draw,
# and key events to them.
class ApplicationWindow < Gosu::Window

  # Window width and height in pixels.
  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480

  # Title bar text.
  WINDOW_NAME = "Gosu fighter"

  # A state may be the game loop or the menu loop. This is made writeable
  # to allow jumping between states.
  attr_writer :state

  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = WINDOW_NAME
    @state = Menu.new self
  end

  # Called every frame before drawing.
  def update
    @state.update if @state.respond_to? :update
  end

  # Called every frame to draw unless the CPU cannot keep up updating.
  def draw
    @state.draw
  end

  # Listens for global button presses and relays them to the state.
  def button_down(button)
    if button == Gosu::KbEscape
      close
    elsif @state.respond_to? :button_down
      @state.button_down button
    end
  end
end

