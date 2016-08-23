require './app/map.rb'
require './app/player.rb'

# Handles the game loop.
class Game
  def initialize
    @player = Player.new
    @map = Map.new
    @frames = 0
    @difficulty = 0
  end

  def update
    @player.update
    @map.update
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

  def draw
    @player.draw
    @map.draw
  end

end
