require './app/bullets/bullet_list.rb'
require './app/map'
require './app/player'
require './app/scope'
require './app/enemy'

# Handles the game loop.
class Game
  def initialize
    @player = Player.new
    @map = Map.new
    @scope = Scope.new
    @bullets = BulletList.new
    @lifes_counter = Gosu::Font.new(20)

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
      @player.remove_life
    end
    @bullets.delete_if do |bullet|
      @map.colliding? bullet
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
    @lifes_counter.draw("LIFES: #{@player.lifes}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(button)
    case button
      when Gosu::MsLeft
        bullet = @player.fire!(@scope.x, @scope.y)
        @bullets << bullet if bullet
    end
  end
end
