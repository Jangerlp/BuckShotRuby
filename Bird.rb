require 'ruby2d/image'

class Bird
  attr_reader :player, :bullets, :bulletText
  attr_writer :dy, :dy, :bullets

  def initialize

    @dx = 2
    @dy = 2
    @bullets = 5

    @player = Image.new(
      './assets/Bird.png',
      x: 450, y: 450,
      width: 65, height: 78,
      z: 2
    )
    @outOfBoundsCircle = Circle.new(
      x: @player.x, y: 30,
      radius: 10,
      color: 'silver'
    )
    @gun = Image.new(
      './assets/Gun.png',
      x: @player.x, y: @player.y,
      width: 200, height: 200,
      rotate: 0,
      z: 1
    )

    @bulletText = Text.new(
      @bullets,
      x: 320,
      y: 200,
      size: 500,
      color: 'gray',
      font: './assets/Montserrat-ExtraBold.ttf'
    )

    @gunShotSound = Sound.new('./assets/Gunshot.wav')
    @gunShotSound.volume = 5

    @gunOutOfAmoSound = Sound.new('./assets/CantShoot.wav')
    @gunOutOfAmoSound.volume = 10
  end

  def move
    @dy = @dy + 0.4
    @dx = @dx * 0.8

    if @dy > 10
      @dy = 10
    end

    @player.y = @player.y + @dy
    @player.x = @player.x + @dx


    if(@player.x > 1000)
      @player.x = 0
    elsif(@player.x < 0)
      @player.x = 1000
    end

    if(@player.y < 0)
      @outOfBoundsCircle.color = 'maroon'
      @outOfBoundsCircle.x = @player.x + 20
    else
      @outOfBoundsCircle.color = 'silver'
    end



    @gun.x = @player.x - 80
    @gun.y = @player.y - 60
  end

  def shot(mouseX, mouseY)
    if(@bullets == 0)
      @gunOutOfAmoSound.play
      return
    end


    moveX = ((@player.x + @player.width/2) - mouseX) * 0.3

    moveY = (@player.y - mouseY) * 0.03

    if moveY < -75
      moveY = -75
    end

    if @player.y < 0
      moveY = 0
    end

    @dx = moveX
    @dy = moveY
    @bullets = @bullets - 1
    @bulletText.text = @bullets

    @gunShotSound.play
  end

  def rotateGun(mouseX, mouseY)
    width = (@player.x + @player.width/2) - mouseX
    height = (@player.y + @player.height/2) - mouseY

    angle = Math.atan(height/width) * (180 / 3.14)

    if width >= 0
      angle = angle - 180
    end

    @gun.rotate = angle
  end


end
