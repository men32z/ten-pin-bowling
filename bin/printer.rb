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

    def print_lane(lane)
      pt = 'Pinfalls '
      sc = "Score\t"
      (lane.frames.count - 1).times do |i|
        f = lane.frames[i]
        pt += if f.values[0] == 10
                "  X\t"
              elsif f.values.sum == 10
                "#{f.values[0]} /\t"
              else
                "#{f.values[0]} #{f.values[1]}\t"
              end
        sc += "#{f.score}\t"
      end
      pt += last_frame_printing(lane)
      sc += "#{lane.frames[9].score}\t" if lane.frames[9]
      puts pt
      puts sc
    end

    def last_frame_printing(lane)
      return unless lane.frames[9]

      v = lane.frames[9].values
      pt = parse_strike(v[0]) + ' ' if v[0]
      pt += parse_strike(v[1], parse_spare(v[1], v[0])) + ' ' if v[1]
      pt += parse_strike(v[2], parse_spare(v[2], v[1])) + ' ' if v[2]
      pt
    end

    private

    def parse_strike(val, val2 = false)
      (val == 10 ? 'X' : val2 || val).to_s
    end

    def parse_spare(val1, val2)
      (val1 + val2 == 10 ? '/' : val1).to_s
    end
  end
end
