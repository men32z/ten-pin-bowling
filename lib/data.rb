require './lib/throw'

class GameData
  attr_reader :players, :throws
  def initialize(data)
    @data = data
    @throws = []
  end

  def format(format)
    @data.each do |x|
      vals = *x.split(format)
      @throws.push(Throw.new(vals[0].strip, vals[1].strip))
    end

    @players = @throws.uniq(&:name).map(&:name)
  end
end
