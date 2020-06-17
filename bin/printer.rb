class Printer
  class << self
    def print(game)
      pt = "Frame\t\t"
      10.times { |i| pt += "#{i + 1}\t\t" }
      pt += "\n"

      game.lanes.each do |l|
        pt += l.player.name + "\n"
        # pinfalls and scores
        pt += print_lane(l) + "\n"
      end
      pt
    end

    def print_lane(lane)
      pt = "Pinfalls\t"
      sc = "Score\t\t"
      (lane.frames.count - 1).times do |i|
        f = lane.frames[i]
        pt += if f.values[0] == 10
                "\tX\t"
              elsif f.values.sum == 10
                "#{f.values[0]}\t/\t"
              else
                "#{f.values[0]}\t#{f.values[1]}\t"
              end
        sc += "#{f.score}\t\t"
      end
      pt += last_frame_printing(lane)
      sc += lane.frames[9].score.to_s if lane.frames[9]

      pt + "\n" + sc
    end

    def last_frame_printing(lane)
      return unless lane.frames[9]

      v = lane.frames[9].values
      pt = parse_strike(v[0]) + "\t" if v[0]
      pt += parse_strike(v[1], parse_spare(v[1], v[0])) + "\t" if v[1]
      pt += parse_strike(v[2], parse_spare(v[2], v[1])) + "\t" if v[2]
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
