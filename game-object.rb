require 'ruby2d'

class GameObject
  attr_writer :object

  def initialize(x, y, width, height, img)
    @object = Image.new(
      img,
      x: x, y: y,
      width: width, height: height
    )
  end

  def collided_with_bird(bird)
    if @object.y < 0
      return false
    end

    bird.x < @object.x + @object.width &&
      bird.x + bird.width > @object.x &&
      bird.y < @object.y + @object.height &&
      bird.y + bird.width > @object.y
  end
end
