require 'ruby2d'
require './Game'
require './MainMenu'

set title: "BuckShot"
set background: 'silver'
set fps_cap: 60
set width: 1000
set height: 1000

isInMainMenu = true

song = Music.new('./assets/music.mp3', loop: true)
song.volume = 5
song.play

unless File.exist?("ifYouTouchThisFileYouCheat.txt")
  File.write("ifYouTouchThisFileYouCheat.txt", 0)
end

mainMenu = MainMenu.new()
mainMenu.show
mainMenu.setHighScore
game = Game.new()

update do
  if(isInMainMenu)
    mainMenu.moveText
  else
    if(game.gameOver)
      clear
      isInMainMenu = true
      mainMenu.show
      mainMenu.setHighScore
    else
      game.updateCheck
    end
  end
end

on :mouse_down do |event|
  if(isInMainMenu)
    if(
      event.x > mainMenu.difficultyButton.x &&
      event.x < mainMenu.difficultyButton.x + mainMenu.difficultyButton.width &&
      event.y > mainMenu.difficultyButton.y &&
      event.y < mainMenu.difficultyButton.y + mainMenu.difficultyButton.height
    )
      if mainMenu.difficulty == 2
        mainMenu.difficulty = 0
      else
        mainMenu.difficulty = mainMenu.difficulty + 1
      end
      mainMenu.updateDifficultyButton
    else
      isInMainMenu = false
      clear
      game.start(mainMenu.difficulty)
    end
  else
    game.bird.shot(event.x, event.y)
  end
end

show