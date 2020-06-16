require './lib/validate'

class FrameFinal
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
    @values.count < 2 || (@values.count == 2 && third_shoot_valid)
  end

  def max_next_value
    max = 10 - @values.sum
    max += 10 if has_first_strike
    max += 10 if has_second_strike
    max += 10 if has_spare
    max
  end

  def has_first_strike
    @values[0] && @values[0] == 10
  end

  private

  def third_shoot_valid
    @values[1] && (has_first_strike || has_spare)
  end

  def has_second_strike
    @values[1] && @values[1] == 10
  end

  def has_spare
    @values[1] && @values[0] + @values[1] == 10
  end
end
