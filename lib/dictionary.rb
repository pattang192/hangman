# dictionary.rb

# holds game's word set and core methods
module Dictionary
full_dictionary = File.open('dictionary.txt', 'r').read.split()
DICTIONARY = full_dictionary.select{ |word| word.length.between?(5, 12)}
end