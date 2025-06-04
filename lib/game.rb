# game.rb
require_relative 'dictionary'
require_relative 'display'

class Game
  include Dictionary
  include Display
  def initialize
    @word = WORD.split('').join(' ')
    @redacted = REDACTED.split('').join(' ')
    @wrong_guesses = []
    @all_guesses = []
  end

  def play
    intro
    loop do
    input_guess
    update_display(@redacted, @wrong_guesses)
    conclusion
    end
  end

  def input_guess
    choose_letter
    letter = gets.chomp.upcase
    validate_input(letter)
  end

  def validate_input(letter)
    if letter.between?('A', 'Z') && !@all_guesses.include?(letter)
    check_guess(letter)
    else
      invalid_input
      input_guess
    end
  end

  def check_guess(letter)
    if @word.include?(letter)
     correct = (0...@word.length).find_all { |i| @word[i] == "#{letter}" }
     correct.each { |i| @redacted[i] = letter }
    else
      @wrong_guesses << letter
    end
  end

  def conclusion
  end
  
end