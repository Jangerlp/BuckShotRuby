require './game-object'

class Obstacle < GameObject
  def initialize
    @img = %w[./assets/Fish.png ./assets/Bone.png ./assets/Shell.png]
    super(0, 0, 40, 50, @img[rand(0...2)])

    randomize_location_and_speed
    @object.y = rand(100...2000) * -1
  end

  def randomize_location_and_speed
    @object.y = 0
    @object.x = rand(100...900)
    @text_move_dy = rand(3...6)
  end

  def move
    @object.y = @object.y + @text_move_dy
    if @object.y > 1000
      randomize_location_and_speed
    end
  end
end