class Player
  attr_accessor :name
  def initialize(name = false)
    @name = (name || 'player' + rand(1..99_999_999).to_s)
  end
end
