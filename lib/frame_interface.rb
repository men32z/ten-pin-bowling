class FrameInterface
  # interface duck typing
  def initialize(frame)
    @frame = frame
  end

  def shoot(s)
    @frame.shoot(s)
  end

  def get_values
    @frame.get_values
  end

  def max_next_value
    @frame.max_next_value
  end

  def available_trows?
    @frame.available_trows?
  end
end
