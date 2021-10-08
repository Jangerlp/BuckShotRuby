require 'ruby2d'

class MainMenu
  attr_reader :difficulty, :difficultyButton
  attr_writer :difficulty

  def initialize
    @difficulty = 0
    @dy = 0
  end

  def show
    Text.new(
      'BuckShot',
      x: 230,
      y: 180,
      size: 100,
      color: 'maroon',
      font: './assets/Montserrat-ExtraBold.ttf'
    )

    Image.new(
      './assets/Bird.png',
      x: 450, y: 450,
      width: 65, height: 78,
      z: 1
    )

    @clickToPlay = Text.new(
      'Click to play',
      x: 330,
      y: 600,
      size: 50,
      color: 'gray',
      font: './assets/Montserrat-ExtraBold.ttf'
    )

    @highscore = Text.new(
      'Highscore: 0',
      x: 355,
      y: 675,
      size: 40,
      color: 'gray',
      font: './assets/Montserrat-ExtraBold.ttf'
    )

    @difficultyButton = Rectangle.new(
      x: 350,
      y: 850,
      width: 300,
      height: 75,
      color: 'lime'
    )

    @difficultyText = Text.new(
      "Easy",
      x: 450,
      y: 865,
      color: 'white',
      size: 40
    )

    @spawnSound = Sound.new('./assets/Spawn.wav')
    @spawnSound.volume = 10

    updateDifficultyButton
  end

  def moveText
    @dy = @dy + 0.1
    pos = Math.sin(@dy) * 2

    @clickToPlay.y = @clickToPlay.y + pos
    @highscore.y = @clickToPlay.y + 75

  end

  def setHighScore
    txt = File.read("ifYouTouchThisFileYouCheat.txt")
    @highscore.text = "Highscore: #{txt}"
  end

  def updateDifficultyButton
    @spawnSound.play

    difficulties = ["Easy", "Hard", "GOD"]
    difficultyColors = ["lime", "orange", "red"]

    @difficultyButton.color = difficultyColors[@difficulty]
    @difficultyText.text = difficulties[@difficulty]
  end
end
