# frozen_string_literal: true

class LaneInterface
  def initialize(lane)
    @lane = lane
  end

  def throw(t)
    @lane.throw(t)
  end

  def set_score(current_frame_index)
    @lane.set_score(current_frame_index)
  end

  def get_frames
    @lane.frames
  end

  def current_frame
    @lane.current_frame
  end
end
