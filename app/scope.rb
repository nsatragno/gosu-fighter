class Scope

  SCOPE_Z_INDEX = 99

  def initialize
    @sprite = Sprites::SCOPE
    @angle = 0
  end

  def update
    @x = Global.instance.window.mouse_x
    @y = Global.instance.window.mouse_y
  end

  def draw
    @sprite.draw_rot @x, @y, SCOPE_Z_INDEX, 0
  end
end
