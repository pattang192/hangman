# main.rb
require "rubocop"
require_relative "lib/game"
require_relative "lib/dictionary"
require_relative "lib/display"

Game.new.play
