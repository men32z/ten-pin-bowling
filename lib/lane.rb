# frozen_string_literal: true

require './lib/frame'
require './lib/frame_final'

class Lane
  attr_reader :frames, :player
  def initialize(player)
    @frames = [Frame.new]
    @player = player
  end

  def throw(t)
    check_frame
    set_score(current_frame_index)  if current_frame.shoot(t)
  end

  def set_score(cfi)
    return set_last_score if cfi == 9

    f = @frames[cfi].get_values[0]
    s = @frames[cfi].get_values[1]

    set_third(cfi - 2, f)
    set_second(cfi - 1, f, s)
    @frames[cfi].score = f + s + last_score(cfi) if f && s && f + s < 10
  end

  def set_last_score
    f = @frames[9].get_values[0]
    s = @frames[9].get_values[1]
    t = @frames[9].get_values[2]
    set_third(7, f)
    if s && f == 10
      set_third(8, s)
    else
      set_second(8, f, s)
    end
    @frames[9].score = f + s + last_score(9) if f && s && f + s < 10
    @frames[9].score = f + s + t + last_score(9) if f && s && t && f + s > 10
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
    if !current_frame.available_trows? && @frames.count < 10
      @frames.push last_frame? ? FrameFinal.new : Frame.new
    end
  end

  def last_frame?
    @frames.count == 9
  end

  def set_second(cfi, f, s)
    if cfi >= 0 && !@frames[cfi].score && (s || !@frames[cfi].has_first_strike)
      @frames[cfi].score = f + 10 + last_score(cfi) + (@frames[cfi].has_first_strike ? s : 0)
    end
  end

  def set_third(cfi, f)
    if cfi >= 0 && !@frames[cfi].score
      add = @frames[cfi + 1].get_values[0] == 10 ? 10 : 0
      add += @frames[cfi].get_values[0] == 10 ? 10 : 0
      @frames[cfi].score = f + add + last_score(cfi)
    end
  end
end
