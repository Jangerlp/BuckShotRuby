require './Object'

class Obstacle < Object1
  def initialize
    x = rand(100...900)
    y = rand(100...2000) * -1
    dy = rand(3...6)
    @img = ['./assets/Fish.png', './assets/Bone.png', './assets/Shell.png']
    super(x, y, dy, 40, 50, @img[rand(0...2)])
  end

  def move
    @object.y = @object.y + @dy
    if @object.y > 1000
      @object.y = 0
      @object.x = rand(100...900)
      @dy = rand(3...6)
    end
  end
end