require './lib/frame'
require './lib/frame_final'

class Lane
  attr_reader :frames, :player
  def initialize(player)
    @frames = [Frame.new]
    @player = player
  end

  def throw(throw)
    check_frame
    score(current_frame_index) if current_frame.shoot(throw)
  end

  def score(cfi)
    return set_last_score if cfi == 9

    f = @frames[cfi].values[0]
    s = @frames[cfi].values[1]

    set_third(cfi - 2, f)
    set_second(cfi - 1, f, s)
    @frames[cfi].score = f + s + last_score(cfi) if f && s && f + s < 10
  end

  def set_last_score
    f = @frames[9].values[0]
    s = @frames[9].values[1]
    t = @frames[9].values[2]

    return unless f

    set_third(7, f)

    return unless s

    if f == 10
      set_third(8, s)
    else
      set_second(8, f, s)
    end
    @frames[9].score = f + s + last_score(9)
    return unless t

    @frames[9].score += t if f + s >= 10
  end

  def last_score(cfi)
    (cfi - 1 >= 0 ? @frames[cfi - 1].score : 0)
  end

  def current_frame_index
    @frames.count - 1
  end

  def current_frame
    @frames[@frames.count - 1]
  end

  private

  def check_frame
    return unless !current_frame.available_trows? && @frames.count < 10

    @frames.push last_frame? ? FrameFinal.new : Frame.new
  end

  def last_frame?
    @frames.count == 9
  end

  def set_second(cfi, first, second)
    return unless cfi >= 0 && !@frames[cfi].score && (second || !@frames[cfi].first_strike?)

    @frames[cfi].score = first + 10 + last_score(cfi) + (@frames[cfi].first_strike? ? second : 0)
  end

  def set_third(cfi, first)
    return unless cfi >= 0 && !@frames[cfi].score

    add = @frames[cfi + 1].values[0] == 10 ? 10 : 0
    add += @frames[cfi].values[0] == 10 ? 10 : 0
    @frames[cfi].score = first + add + last_score(cfi)
  end
end
