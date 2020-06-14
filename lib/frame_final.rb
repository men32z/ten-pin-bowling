require "./lib/validate"

class FrameFinal
  def initialize
    @values = []
  end

  def shoot(s)
    s = 0 if s == "F"
    validator = Validate.new(s, "min:0|max:10|number")
    @values.push s if validator.valid? && (!@values[0] || second_shoot_valid(s) || third_shoot_valid(s))
  end

  def get_values
    @values
  end

  private

  def third_shoot_valid(s)
    @values[1] && (has_first_strike(s) || has_spare || has_two_strikes)
  end

  def second_shoot_valid(s)
    @values[0] && !@values[1] && (@values[0] == 10 || @values[0] + s <= 10)
  end

  def has_first_strike(s)
    @values[0] == 10 && @values[1] + s <= 10
  end

  def has_spare
    @values[0] + @values[1] == 10
  end

  def has_two_strikes
    @values[0] + @values[1] == 20
  end
end