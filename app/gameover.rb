require 'gosu'
# display the gameover screen
class GameOver
  GAMEOVER_Z_INDEX = 1
  def initialize
    @message_font = Gosu::Font.new(60)
    @other_font = Gosu::Font.new(10)
  end

  def button_down(button)
    case button
    when Gosu::KbReturn then
        Global.instance.window.state = Menu.new
    end
  end

  def draw
    #@screen.draw 0, 0, GAMEOVER_Z_INDEX
    @message_font.draw("G A M E  O V E R", ApplicationWindow::WINDOW_WIDTH / 2 - 250, ApplicationWindow::WINDOW_HEIGHT / 2, 1, 1.0, 1.0,
      Gosu::Color::WHITE)
    @other_font.draw("Press RETURN to go back to the menu", ApplicationWindow::WINDOW_WIDTH / 2 - 250, (ApplicationWindow::WINDOW_HEIGHT / 2) + 60, 1, 1.0, 1.0,
      Gosu::Color::WHITE)
  end
end
