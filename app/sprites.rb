# Preloads and shares sprites.

module Sprites
  PLAYER = Gosu::Image.new "assets/player.png"
  WALL = Gosu::Image.new "assets/wall.png", :tileable => true
end
