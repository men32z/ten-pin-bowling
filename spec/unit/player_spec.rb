require './lib/player'

RSpec.describe Player do
  let(:player) { Player.new }
  describe '#initialize' do
    it 'returns player object of the class Player' do
      expect(player).to be_an(Player)
    end

    it "has a default name 'player' plus id" do
      player2 = Player.new
      expect(player.name).to match(/player/)
      expect(player2.name).to match(/player/)
      expect(player.name).to_not eq(player2.name)
    end

    it "player can be initialized with name, and should be accessible." do
      mike = Player.new("Mike")
      expect(mike.name).to eq("Mike")
    end
  end
end