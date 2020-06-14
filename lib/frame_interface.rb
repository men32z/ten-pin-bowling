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
end