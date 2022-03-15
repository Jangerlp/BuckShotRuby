require 'ruby2d'
require './bird'
require './bullet'
require './obstacle'

class Game
  attr_reader :bird, :game_over

  def initialize
    @game_over = false
    @bullets = []
    @game_over_sound = Sound.new('./assets/Error.wav')
    #@game_over_sound.volume = 5
    @gun_reload_sound = Sound.new('./assets/Reload.wav')
    #@gun_reload_sound.volume = 5
    @spawn_sound = Sound.new('./assets/Spawn.wav')
    #@spawn_sound.volume = 10
  end

  def start(difficulty)
    @score = 0
    @game_over = false
    @bird = Bird.new
    @bullets = [Bullet.new, Bullet.new]
    @bullets_per_reload = 2
    @obstacles = []

    if difficulty > 0
      @obstacles = [Obstacle.new, Obstacle.new, Obstacle.new]
      if difficulty > 1
        @bullets_per_reload = 1
      end
    end

    @score_text = Text.new(
      "Score: #{@score}",
      x: 10,
      y: 10,
      size: 30,
      color: 'gray',
      font: './assets/Montserrat-ExtraBold.ttf'
    )
    @spawn_sound.play
  end

  def update_check
    if @bird.player.y < 1000
      @bird.move
      @bird.rotate_gun(Window.mouse_x, Window.mouse_y)
      @obstacles.map do |obstacle|
        if obstacle.collided_with_bird(@bird.player)
          die
        else
          obstacle.move
        end
      end
      @bullets.map do |bullet|
        if bullet.collided_with_bird(@bird.player)
          bullet.randomize_location
          reload
        end
      end
    else
      die
    end
  end

  def die
    @game_over_sound.play
    set_highscore
    @game_over = true
  end

  def reload
    @bird.bullets += @bullets_per_reload
    @gun_reload_sound.play
    @bird.bullet_count_text.text = @bird.bullets
    @score = @score + 1
    @score_text.text = "Score: #{@score}"
  end

  def set_highscore
    if File.exist?("highscore.txt")
      current_highscore = File.read("highscore.txt")
      if @score > Integer(current_highscore)
        File.write("highscore.txt", @score)
      end
    end
  end
end
