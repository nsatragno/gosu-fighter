# Preloads and shares sprites.

module Sprites
  ABOUT = Gosu::Image.new "assets/about.png"
  MENU = Gosu::Image.new "assets/menu.png"
  PIXEL = Gosu::Image.new "assets/pixel.png"
  PLAYER = Gosu::Image.new "assets/player.png"
  WALL = Gosu::Image.new "assets/wall.png", :tileable => true
end
