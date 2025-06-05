# main.rb
require "rubocop"
require "json"
require_relative "lib/game"
require_relative "lib/dictionary"
require_relative "lib/display"
include Display

def play_game
  if File.exist?("./game.json")
    retrieve_game
  else
    Game.new.play
  end
end

def retrieve_game
  Display.continue_game
  continue = gets.chomp.downcase
  if continue == "y"
    deserialize_game
  else
    Game.new.play
  end
end

def deserialize_game
  data = File.read("./game.json")
  File.delete("./game.json")
  obj = JSON.parse(data)
  Game.new(obj).play
end
# Game.new.play
play_game
