require './lib/validate'

class FrameFinal
  attr_accessor :score
  attr_reader :values

  def initialize
    @values = []
    @score = false
  end

  def shoot(shoot)
    shoot = 0 if shoot == 'F'
    validator = Validate.new(shoot, "min:0|max:#{max_next_value}|number")
    return false if !validator.valid? || !available_trows?

    @values.push shoot
  end

  def available_trows?
    @values.count < 2 || (@values.count == 2 && third_shoot_valid)
  end

  def max_next_value
    max = 10 - @values.sum
    max += 10 if first_strike?
    max += 10 if second_strike?
    max += 10 if spare?
    max
  end

  def first_strike?
    @values[0] && @values[0] == 10
  end

  private

  def third_shoot_valid
    @values[1] && (first_strike? || spare?)
  end

  def second_strike?
    @values[1] && @values[1] == 10
  end

  def spare?
    @values[1] && @values[0] + @values[1] == 10
  end
end
