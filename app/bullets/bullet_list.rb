class BulletList < Array

  def update
    delete_if do |bullet|
      bullet.update
      bullet.x < 0 ||
        bullet.x > ApplicationWindow::WINDOW_WIDTH ||
        bullet.y < 0 ||
        bullet.y > ApplicationWindow::WINDOW_HEIGHT
    end
  end

  def draw
    each do |bullet|
      bullet.draw
    end
  end
end
