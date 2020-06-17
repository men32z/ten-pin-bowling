require './lib/validate.rb'

class Frame
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
    @values[0] && @values[0] == 10 ? false : (2 - @values.count).positive?
  end

  def max_next_value
    10 - @values.sum
  end

  def first_strike?
    @values[0] && @values[0] == 10
  end
end
