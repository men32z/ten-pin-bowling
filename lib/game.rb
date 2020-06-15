require "./lib/lane"
require "./lib/player"

class Game
  attr_reader :lanes
  def initialize(players)
    @lanes = []
    players.each do |x|
      @lanes.push Lane.new(Player.new(x))
    end
  end

  def insert(player_string, shoot)
     @lanes.find {|x| x.user.name == player_string}.shoot(shoot)
  end
end