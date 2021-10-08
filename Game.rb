require 'ruby2d'
require './Bird'
require './Bullet'
require './Obstacle'

class Game
  attr_reader :bird, :gameOver

  def initialize
    @gameOver = false
    @bullets = []
    @gameOverSound = Sound.new('./assets/Error.wav')
    @gameOverSound.volume = 5

    @gunReloadSound = Sound.new('./assets/Reload.wav')
    @gunReloadSound.volume = 5

    @spawnSound = Sound.new('./assets/Spawn.wav')
    @spawnSound.volume = 10
  end

  def start(difficulty)
    @gameOver = false
    @bird = Bird.new
    @bullets = [Bullet.new, Bullet.new]
    @bulletsPerReload = 2
    @obstacles = []
    if difficulty > 0
      @obstacles = [Obstacle.new, Obstacle.new, Obstacle.new]
    end
    if difficulty > 1
      @bulletsPerReload = 1
    end
    @score = 0

    @scoreText = Text.new(
      "Score: #{@score}",
      x: 10,
      y: 10,
      size: 30,
      color: 'gray',
      font: './assets/Montserrat-ExtraBold.ttf'
    )
    @spawnSound.play
  end

  def updateCheck
    if @bird.player.y < 1000
      @bird.move
      @bird.rotateGun(Window.mouse_x, Window.mouse_y)
      @obstacles.map do |obstacle|
        if(obstacle.collidedWithBird(@bird.player.x, @bird.player.y, @bird.player.width, @bird.player.height))
          die
        else
          obstacle.move
        end
      end
      @bullets.map do |bullet|
        if bullet.collidedWithBird(@bird.player.x, @bird.player.y, @bird.player.width, @bird.player.height)
          bullet.randomLocation
          reload
        end
      end
    else
      die
    end
  end

  def die
    @gameOverSound.play
    setHighScore
    @gameOver = true
  end

  def reload
    @bird.bullets = @bird.bullets + @bulletsPerReload
    @gunReloadSound.play
    @bird.bulletText.text = @bird.bullets
    @score = @score + 1
    @scoreText.text = "Score: #{@score}"
  end

  def setHighScore
    if File.exist?("ifYouTouchThisFileYouCheat.txt")
      currentHighScore = File.read("ifYouTouchThisFileYouCheat.txt")
      if @score > Integer(currentHighScore)
        File.write("ifYouTouchThisFileYouCheat.txt", @score)
      end
    end
  end
end
