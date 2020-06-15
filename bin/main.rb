# frozen_string_literal: true

require './lib/game'
require './lib/file_helper'
require './lib/data'

puts 'insert file directory or write def to use default file'
f = gets.chomp
file = FileHelper.read(f == 'def' ? './docs/example.txt' : f)

if file
  puts 'staring game'
  data = GameData.new(file)
  data.format(' ')
  game = Game.new(data.players)

  # making throws
  data.throws.each do |t|
    game.lanes.find { |l| l.player.name == t.name }.throw(t.shoot.to_i)
  end
  # printing scores
  # Frame section
  pt = "Frame\t"
  10.times { |i| pt += "#{i + 1}\t" }
  puts pt

  game.lanes.each do |l|
    # name
    puts l.player.name
    # pinfalls and scores
    pt = 'Pinfalls '
    sc = "Score\t"
    (l.frames.count - 1).times do |i|
      f = l.frames[i]
      pt += if f.get_values[0] == 10
              "  X\t"
            elsif f.get_values.sum == 10
              "#{f.get_values[0]} /\t"
            else
              "#{f.get_values[0]} #{f.get_values[1]}\t"
            end
      sc += "#{f.score}\t"
    end
    if l.frames[9]
      v = l.frames[9].get_values
      # last item
      pt += (v[0] == 10 ? 'X ' : "#{v[0]} ").to_s
      pt += (v[1] == 10 ? 'X ' : (v[1] + v[0] == 10 ? '/ ' : "#{v[1]} ")).to_s
      pt += (v[2] == 10 ? 'X ' : (v[2] + v[1] == 10 ? '/ ' : "#{v[2]} ")).to_s if v[2]

      sc += "#{l.frames[9].score}\t"
    end

    puts pt
    puts sc
  end
else
  puts "wrong file or doesn't exist"
end
