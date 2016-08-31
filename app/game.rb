require './app/bullets/bullet_list.rb'
require './app/map'
require './app/player'
require './app/scope'

# Handles the game loop.
class Game
  def initialize
    @player = Player.new
    @map = Map.new
    @scope = Scope.new
    @bullets = BulletList.new

    @frames = 0
    @difficulty = 0
  end

  def update
    @player.update
    @map.update
    @scope.update
    @bullets.update
    if @map.colliding? @player then
      @map.stop_moving!
      @player.die!
    end
    @frames += 1
    if @frames % 256 == 0 then
      @difficulty += 1
      @map.set_difficulty! @difficulty
    end
  end

  def draw
    @player.draw
    @map.draw
    @scope.draw
    @bullets.draw
  end

  def button_down(button)
    case button
      when Gosu::MsLeft
        @bullets << @player.fire!(@scope.x, @scope.y)
    end
  end
end
