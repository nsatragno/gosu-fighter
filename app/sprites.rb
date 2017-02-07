# Preloads and shares sprites.

module Sprites
  ABOUT = Gosu::Image.new "assets/about.png"
  MENU = Gosu::Image.new "assets/menu.png"
  PIXEL = Gosu::Image.new "assets/pixel.png"
  PLAYER = Gosu::Image.new "assets/player.png"
  SCOPE =  Gosu::Image.new "assets/scope.png"
  WALL = Gosu::Image.new "assets/wall.png", :tileable => true
  ENEMY = Gosu::Image.new "assets/enemy.png"
end
