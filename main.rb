require 'ruby2d'
require './game'
require './main_menu'

set title: "BuckShot"
set background: 'silver'
set fps_cap: 60
set width: 1000
set height: 1000

is_in_main_menu = true

song = Music.new('./assets/music.mp3', loop: true)
#song.volume = 5
song.play

unless File.exist?("highscore.txt")
  File.write("highscore.txt", 0)
end

game = Game.new
main_menu = MainMenu.new
main_menu.show
main_menu.set_highscore

update do
  if is_in_main_menu
    main_menu.move_text
  else
    if game.game_over
      clear
      is_in_main_menu = true
      main_menu.show
      main_menu.set_highscore
    else
      game.update_check
    end
  end
end

on :mouse_down do |event|
  if is_in_main_menu
    if is_difficulty_button_clicked(event, main_menu)
      change_difficulty(main_menu)
    else
      is_in_main_menu = false
      clear
      game.start(main_menu.difficulty)
    end
  else
    game.bird.shot(event.x, event.y)
  end
end

def is_difficulty_button_clicked(event, main_menu)
  event.x > main_menu.difficulty_button_shape.x &&
    event.x < main_menu.difficulty_button_shape.x + main_menu.difficulty_button_shape.width &&
    event.y > main_menu.difficulty_button_shape.y &&
    event.y < main_menu.difficulty_button_shape.y + main_menu.difficulty_button_shape.height
end

def change_difficulty(main_menu)
  if main_menu.difficulty == 2
    main_menu.difficulty = 0
  else
    main_menu.difficulty = main_menu.difficulty + 1
  end
  main_menu.update_difficulty_button
end

show