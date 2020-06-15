require "./lib/throw"

class GameData
  attr_reader :players, :throws
  def initialize(data)
    @data = data
    @throws = []
  end

  def format(format)
    @data.each do |x|
      @throws.push(Throw.new(*x.split(format)))
    end

    @players = @throws.uniq(&:name).map(&:name)
  end
end