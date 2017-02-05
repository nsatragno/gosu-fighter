require 'matrix'

require "./app/sprites"

# The enemy class.
class Enemy
  def initialize
    @x = 300
    @y = 300

    @color = 0xff_ffffff
    @sprite = Sprites::ENEMY

    @state = :alive
  end

  def update
  end
end
