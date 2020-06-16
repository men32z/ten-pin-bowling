class FrameInterface
  # interface duck typing
  def initialize(frame)
    @frame = frame
  end

  def shoot(shoot)
    @frame.shoot(shoot)
  end

  def values
    @frame.values
  end

  def max_next_value
    @frame.max_next_value
  end

  def available_trows?
    @frame.available_trows?
  end
end
