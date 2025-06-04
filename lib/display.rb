# display.rb
require_relative "game"

# content the player sees
module Display
  include Dictionary
  def intro(redacted, wrong_guesses)
    puts "Welcome to Hangman"
    puts "Try to guess the secret word...but be wary...8 wrong letters and you're a goner x_x"
    update_display(redacted, wrong_guesses)
  end

  def choose_letter
    puts "\nEnter a letter."
  end

  def invalid_input
    puts "Invalid input. Try again"
  end

  def update_display(redacted, wrong_guesses)
    puts redacted + "    #{wrong_guesses.size} wrong: " + wrong_guesses.join(" ")
  end

  def player_wins
    puts "Yay! You got it!"
  end

  def gameover(word)
    puts "Gameover. The word was: #{word}"
  end

  def replay
    puts "\nGuess another word? y/n"
    replay = gets.chomp.downcase
    if replay == "y"
      Game.new.play
    else
      puts "Thank you for playing."
      exit
    end
  end
end
