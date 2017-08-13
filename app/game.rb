require './app/bullets/bullet_list.rb'
require './app/enemies/asteroid'
require './app/map'
require './app/player'
require './app/scope'
require './app/enemy'
require './app/lives_counter'

# Handles the game loop.
class Game
  def initialize
    @player = Player.new
    @map = Map.new
    @scope = Scope.new
    @bullets = BulletList.new
    @lives_counter = LivesCounter.new(@player)
    @enemies = []

    @frames = 0
    @difficulty = 0
  end

  def update
    @player.update
    @map.update
    @scope.update
    @bullets.update
    @enemies.each do |enemy|
      enemy.update
    end
    if @map.colliding? @player then
      @player.remove_life!
    end
    @bullets.delete_if do |bullet|
      @map.colliding? bullet
    end
    @frames += 1
    if @frames % 256 == 0 then
      @difficulty += 1
      @map.set_difficulty! @difficulty
    end

    if GlobalRandom::rand(50) == 1
      @enemies << Asteroid.new
    end
    @enemies.delete_if do |enemy|
      next true if @map.colliding? enemy

      if @player.colliding? enemy
        @player.remove_life!
         next true
      end

      false
    end

  end

  def draw
    @player.draw
    @map.draw
    @scope.draw
    @bullets.draw
    @lives_counter.draw
    @enemies.each do |enemy|
      enemy.draw
    end
  end

  def button_down(button)
    case button
      when Gosu::MsLeft
        bullet = @player.fire!(@scope.x, @scope.y)
        @bullets << bullet if bullet
    end
  end
end
