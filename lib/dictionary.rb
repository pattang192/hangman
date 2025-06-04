# dictionary.rb

# holds game's word set and core methods
module Dictionary
  full_dictionary = File.read("./lib/dictionary.txt").split
  DICTIONARY = full_dictionary.select { |word| word.length.between?(5, 12) }
end
