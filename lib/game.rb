# game.rb
require_relative 'dictionary'

class Game
  include Dictionary
  include Display
  def initialize
    @secret_word = DICTIONARY.sample.split.join(' ')
    @display = '_ ' * @secret_word.length.trim
    @wrong_guesses = []
  end

  def play
    intro
    input_guess
    check_guess
    update_display
    conclusion
  end

  def input_guess
  end

  def check_guess
  end
  
  def update_display
  end

  def conclusion
  end
  
end