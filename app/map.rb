require './app/global_random'
require './app/wall'

# Handles a lot of walls around the player.
class Map
  STARTING_SPEED = 1

  def initialize
    @ceiling = []
    @floor = []
    @moving = true

    @speed = STARTING_SPEED
    @min_breach = 500
    @max_breach = 600

    create_ceiling! while need_wall? @ceiling
    create_floor! while need_wall? @floor
  end

  def update
    return if not @moving
    create_ceiling! if need_wall? @ceiling
    create_floor! if need_wall? @floor
    [@ceiling, @floor].each do |list|
      list.delete_if do |wall|
        wall.point1[0] -= @speed
        wall.point2[0] -= @speed
        wall.point2[0] < 0
      end
    end
  end

  def set_difficulty!(difficulty)
    return if not @moving
    @min_breach = [50, 500 - difficulty * 50].max
    @max_breach = [100, 600 - difficulty * 50].max
    @speed = STARTING_SPEED + difficulty * 0.3
  end

  def colliding?(entity)
    entity.collision_points.each do |point|
      return true if colliding_with_ceiling? point
      return true if colliding_with_floor? point
    end
    false
  end

  def stop_moving!
    @moving = false
  end

  def draw
    [@ceiling, @floor].each do |list|
      list.each do |wall|
        wall.draw
      end
    end
  end

  private
  # Returns the height of the given wall list at X. If there's no wall at
  # that point, returns nil.
  def get_wall_height_at(x, walls)
    wall = walls.detect do |wall|
      wall.point2[0] > x
    end
    return nil if wall.nil?
    wall_point_y = (x - wall.point1[0]) * wall.y_length / wall.x_length + wall.point1[1]
  end

  def colliding_with_ceiling?(point)
    wall_height = get_wall_height_at point[0], @ceiling
    wall_height && wall_height >= point[1]
  end

  def colliding_with_floor?(point)
    wall_height = get_wall_height_at point[0], @floor
    wall_height && wall_height <= point[1]
  end

  def need_wall?(wall_list)
    return true if wall_list.empty?
    wall_list.last.point2[0] < ApplicationWindow::WINDOW_WIDTH
  end

  def create_ceiling!
    if @ceiling.empty?
      first_point = [0, 0]
    else
      first_point = @ceiling.last.point2
    end
    last_point_x = first_point[0] + GlobalRandom::between(50, 100)

    if @floor.empty?
      highest_floor_point = ApplicationWindow::WINDOW_HEIGHT
    else
      highest_floor_point = @floor
        .map {|wall| 
          [wall.point1[1], wall.point2[1]].min
        }.min
    end
    hardest_last_point_y = [0, highest_floor_point - @min_breach].max
    easiest_last_point_y = [0, highest_floor_point - @max_breach].max

    last_point_y = GlobalRandom::between easiest_last_point_y,
                                         hardest_last_point_y

    @ceiling << Wall.new(first_point, [last_point_x, last_point_y])
  end

  def create_floor!
    if @floor.empty?
      first_point = [0, ApplicationWindow::WINDOW_HEIGHT]
    else
      first_point = @floor.last.point2
    end
    last_point_x = first_point[0] + GlobalRandom::between(50, 100)

    if @ceiling.empty?
      lowest_ceiling_point = 0
    else
      lowest_ceiling_point = @ceiling
        .map {|wall|
          [wall.point1[1], wall.point2[1]].max
        }.max
    end
    hardest_last_point_y = [lowest_ceiling_point + @min_breach,
                            ApplicationWindow::WINDOW_HEIGHT].min
    easiest_last_point_y = [lowest_ceiling_point + @max_breach,
                            ApplicationWindow::WINDOW_HEIGHT].min

    last_point_y = GlobalRandom::between hardest_last_point_y,
                                         easiest_last_point_y
    @floor << Wall.new(first_point, [last_point_x, last_point_y])
  end
end
