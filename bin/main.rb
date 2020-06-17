require './lib/game'
require './lib/file_helper'
require './lib/data'
require './bin/printer'

puts 'insert file directory or write def to use default file'
f = gets.chomp
file = FileHelper.read(f == 'def' ? './docs/example.txt' : f)

if file
  puts 'staring game'
  data = GameData.new(file)
  data.format("\t")
  game = Game.new(data.players)
  game.make_throws(data)

  puts Printer.print(game)
else
  puts "wrong file or doesn't exist"
end
