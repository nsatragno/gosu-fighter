class BulletList

  def initialize
    @list = []
  end

  def update
    @list.delete_if do |bullet|
      bullet.update
      bullet.x < 0 ||
        bullet.x > ApplicationWindow::WINDOW_WIDTH ||
        bullet.y < 0 ||
        bullet.y > ApplicationWindow::WINDOW_HEIGHT
    end
  end

  def draw
    @list.each do |bullet|
      bullet.draw
    end
  end

  def <<(bullet)
    @list << bullet
  end
end
