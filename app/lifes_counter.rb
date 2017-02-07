require './app/player'

class Lifes_Counter
  def initialize(player)
    @player = player;
    @counter = Gosu::Font.new(20)
  end

  def draw
    @counter.draw("LIFES: #{@player.lifes.to_s}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
  end
end
