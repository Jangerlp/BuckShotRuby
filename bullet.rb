require './game-object'

class Bullet < GameObject
  def initialize
    super(0, 0, 40, 50, './assets/Bullet.png')

    randomize_location
  end

  def randomize_location
    @object.x = rand(100...900)
    @object.y = rand(100...600)
  end
end