# Displays the about page.
class About

  ABOUT_Z_INDEX = 1

  def initialize
    @screen = Sprites::ABOUT
  end

  def button_down(button)
    Global.instance.window.state = Menu.new
  end

  def draw
    @screen.draw 0, 0, ABOUT_Z_INDEX
  end
end
