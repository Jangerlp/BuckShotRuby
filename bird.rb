require 'ruby2d/image'

class Bird
  attr_reader :player, :bullet_count_text
  attr_accessor :bullets

  def initialize

    @dx = 2
    @text_move_dy = 2
    @bullets = 5

    @player = Image.new(
      './assets/Bird.png',
      x: 450, y: 450,
      width: 65, height: 78,
      z: 2
    )
    @out_of_bounds_circle = Circle.new(
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

    @bullet_count_text = Text.new(
      @bullets,
      x: 320,
      y: 200,
      size: 500,
      color: 'gray',
      font: './assets/Montserrat-ExtraBold.ttf'
    )

    @gun_shoot_sound = Sound.new('./assets/Gunshot.wav')
    #@gun_shoot_sound.volume = 5

    @gun_out_of_ammo_sound = Sound.new('./assets/CantShoot.wav')
    #@gun_out_of_ammo_sound.volume = 10
  end

  def move
    @text_move_dy = @text_move_dy + 0.4
    @dx = @dx * 0.8

    if @text_move_dy > 10
      @text_move_dy = 10
    end

    @player.y = @player.y + @text_move_dy
    @player.x = @player.x + @dx

    if @player.x > 1000
      @player.x = 0
    elsif @player.x < 0
      @player.x = 1000
    end

    if @player.y < 0
      @out_of_bounds_circle.color = 'maroon'
      @out_of_bounds_circle.x = @player.x + 20
    else
      @out_of_bounds_circle.color = 'silver'
    end

    @gun.x = @player.x - 80
    @gun.y = @player.y - 60
  end

  def shot(mouse_x, mouse_y)
    if @bullets == 0
      @gun_out_of_ammo_sound.play
      return
    end

    move_x = ((@player.x + @player.width/2) - mouse_x) * 0.3
    move_y = (@player.y - mouse_y) * 0.03

    if move_y < -75
      move_y = -75
    end

    if @player.y < 0
      move_y = 0
    end

    @dx = move_x
    @text_move_dy = move_y
    @bullets = @bullets - 1
    @bullet_count_text.text = @bullets

    @gun_shoot_sound.play
  end

  def rotate_gun(mouse_x, mouse_y)
    width = (@player.x + @player.width/2) - mouse_x
    height = (@player.y + @player.height/2) - mouse_y

    angle = Math.atan(height/width) * (180 / 3.14)

    if width >= 0
      angle -= 180
    end

    @gun.rotate = angle
  end


end
