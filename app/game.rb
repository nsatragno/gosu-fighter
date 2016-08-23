require './app/map'
require './app/player'
require './app/scope'

# Handles the game loop.
class Game
  def initialize
    @player = Player.new
    @map = Map.new
    @scope = Scope.new
    @frames = 0
    @difficulty = 0
  end

  def update
    @player.update
    @map.update
    @scope.update
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
    @scope.draw
  end

end
