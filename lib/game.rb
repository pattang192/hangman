# game.rb
require_relative "dictionary"
require_relative "display"

# play a round of hangman
class Game
  include Dictionary
  include Display

  def initialize
    @word = select_word
    @secret_word = @word.split.join
    @redacted = redact_word
    @wrong_guesses = []
    @all_guesses = []
  end

  def play
    intro(@redacted, @wrong_guesses)
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
    if letter_valid?(letter)
      @all_guesses << letter
      check_guess(letter)
    else
      invalid_input
      input_guess
    end
  end

  def letter_valid?(letter)
    letter.between?("A", "Z") &&
      !@all_guesses.include?(letter) &&
      letter.size == 1
  end

  def check_guess(letter)
    if @word.include?(letter)
      correct = (0...@word.length).find_all { |i| @word[i] == letter }
      correct.each { |i| @redacted[i] = letter }
    else
      @wrong_guesses << letter
    end
  end

  def conclusion
    return unless gameover?

    end_game
    replay
  end

  def gameover?
    word_guessed? || out_of_guesses?
  end

  def end_game
    if word_guessed?
      player_wins
    elsif out_of_guesses?
      gameover(@secret_word)
    end
  end

  def word_guessed?
    @redacted == @word
  end

  def out_of_guesses?
    @wrong_guesses.size == 8
  end

  def select_word
    DICTIONARY.sample.upcase.chars.join(" ")
  end

  def redact_word
    redacted = "_" * @secret_word.length
    redacted.chars.join(" ")
  end
end
