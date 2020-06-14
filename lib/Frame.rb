require "./lib/validate"

class Frame
  def initialize
    @values = []
  end

  def shoot(s)
    s = 0 if s == "F"
    validator = Validate.new(s, "min:0|max:10|number")
    return false if (@values[0] && @values[0] + s > 10) || !validator.valid?
    @values.push s
  end

  def get_values
    @values
  end
end