require './lib/validate'

class Frame
  attr_accessor :score

  def initialize
    @values = []
    @score = false
  end

  def shoot(s)
    s = 0 if s == 'F'
    validator = Validate.new(s, "min:0|max:#{max_next_value}|number")
    return false if !validator.valid? || !available_trows?

    @values.push s
  end

  def get_values
    @values
  end

  def available_trows?
    @values[0] && @values[0] == 10 ? false : (2 - @values.count > 0)
  end

  def max_next_value
    10 - @values.sum
  end

  def has_first_strike
    @values[0] && @values[0] == 10
  end
end
