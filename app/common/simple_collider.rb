# Implements a trivial collision checker.
module SimpleCollider
  COLLISION_DISTANCE = 1

  def colliding?(another)
    collision_points.find do |p1|
      another.collision_points.find do |p2|
        Math.sqrt((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2) < COLLISION_DISTANCE
      end
    end
  end
end
