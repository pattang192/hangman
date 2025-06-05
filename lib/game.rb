# game.rb
require_relative "dictionary"
require_relative "display"

# play a round of hangman
class Game
  attr_accessor :word, :redacted, :wrong_guesses, :all_guesses

  include Dictionary
  include Display

  def initialize(options = {})
    @word = options["@word"] || select_word
    @redacted = options["@redacted"] || redact_word
    @wrong_guesses = options["@wrong_guesses"] || []
    @all_guesses = options["@all_guesses"] || []
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
    validate_input(letter) unless letter == "SS"

    save_state
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
      gameover(@word)
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
    word = @word.split.join
    redacted = "_" * word.length
    redacted.chars.join(" ")
  end

  def save_state
    game_state = {}
    instance_variables.map do |var|
      game_state[var] = instance_variable_get(var)
    end
    File.open("game.json", "w+") do |f|
      JSON.dump(game_state, f)
    end
    game_saved
  end
end
