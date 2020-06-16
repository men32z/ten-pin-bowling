class Printer
  class << self
    def print(game)
      pt = "Frame\t"
      10.times { |i| pt += "#{i + 1}\t" }
      puts pt

      game.lanes.each do |l|
        puts l.player.name
        # pinfalls and scores
        print_lane(l)
      end
    end

    def print_lane(l)
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
      pt += last_frame_printing(l)
      sc += "#{l.frames[9].score}\t" if l.frames[9]
      puts pt
      puts sc
    end

    def last_frame_printing(lane)
      return unless lane.frames[9]

      v = lane.frames[9].get_values
      pt = (v[0] && v[0] == 10 ? 'X ' : "#{v[0]} ").to_s
      if v[1]
        not_strike_printing = (v[1] + v[0] == 10 ? '/ ' : "#{v[1]} ")
        pt += (v[1] == 10 ? 'X ' : not_strike_printing).to_s
      end
      if v[2]
        not_strike_printing = (v[2] + v[1] == 10 ? '/ ' : "#{v[2]} ")
        pt += (v[2] == 10 ? 'X ' : not_strike_printing).to_s
      end
      pt
    end
  end
end
