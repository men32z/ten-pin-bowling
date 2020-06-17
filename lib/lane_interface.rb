class LaneInterface
  def initialize(lane)
    @lane = lane
  end

  def throw(throw)
    @lane.throw(throw)
  end

  def score(current_frame_index)
    @lane.score(current_frame_index)
  end

  def frames
    @lane.frames
  end

  def current_frame
    @lane.current_frame
  end
end
