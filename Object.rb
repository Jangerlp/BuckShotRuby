require 'ruby2d'

class Object1
  attr_writer :object, :dy
  attr_reader :dy

  def initialize(x, y, dy, width, height, img)
    @object = Image.new(
      img,
      x: x, y: y,
      width: width, height: height
    )
    @dy = dy
    @destroyed = false
  end

  def move
    @object.y = @object.y + @dy
  end

  def collidedWithBird(birdX, birdY, birdWidth, birdHeight)
    if @destroyed || @object.y < 0
      return false
    end
    if (birdX < @object.x + @object.width &&
      birdX + birdWidth > @object.x &&
      birdY < @object.y + @object.height &&
      birdY + birdWidth > @object.y)
      return true
    else
      return false
    end
  end
end
