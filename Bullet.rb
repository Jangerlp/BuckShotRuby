require './Object'

class Bullet < Object1
  def initialize()
    x = rand(100...900)
    y = rand(100...600)

    super(x, y, 0, 40, 50, './assets/Bullet.png')
  end

  def randomLocation
    @object.x = rand(100...900)
    @object.y = rand(100...600)
  end
end