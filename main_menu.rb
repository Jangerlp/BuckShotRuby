require 'ruby2d'

class MainMenu
  attr_reader :difficulty, :difficulty_button_shape
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

    @click_to_play_text = Text.new(
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

    @difficulty_button_shape = Rectangle.new(
      x: 350,
      y: 850,
      width: 300,
      height: 75,
      color: 'lime'
    )

    @difficulty_button_text = Text.new(
      "Easy",
      x: 450,
      y: 865,
      color: 'white',
      size: 40
    )

    @spawn_sound = Sound.new('./assets/Spawn.wav')
    @spawn_sound.volume = 10

    update_difficulty_button
  end

  def move_text
    @dy = @dy + 0.1
    pos = Math.sin(@dy) * 2

    @click_to_play_text.y = @click_to_play_text.y + pos
    @highscore.y = @click_to_play_text.y + 75

  end

  def set_highscore
    txt = File.read("highscore.txt")
    @highscore.text = "Highscore: #{txt}"
  end

  def update_difficulty_button
    @spawn_sound.play

    difficulties = ["Easy", "Hard", "GOD"]
    difficulty_colors = ["lime", "orange", "red"]

    @difficulty_button_shape.color = difficulty_colors[@difficulty]
    @difficulty_button_text.text = difficulties[@difficulty]
  end
end
