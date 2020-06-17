require './lib/game'
require './lib/file_helper'
require './lib/data'
require './bin/printer'

RSpec.describe 'Perfect Scenario' do
  describe 'perfect scenario' do
    before(:each) do
      file = FileHelper.read('./spec/fixtures/all_10.txt')
      data = GameData.new(file)
      data.format(' ')
      @game = Game.new(data.players)
      @game.make_throws(data)
    end

    it 'scores perfect scenario all strikes.' do
      perfect_scores = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
      expect(@game.lanes[0].frames.map(&:score)).to eq(perfect_scores)
    end

    it 'print in the right format with right data' do
      right_format = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t\nCarl\n"
      right_format += "Pinfalls   X\t  X\t  X\t  X\t  X\t  X\t  X\t  X\t  X\tX X X \n"
      right_format += "Score\t30\t60\t90\t120\t150\t180\t210\t240\t270\t300\t\n"
      expect(Printer.print(@game)).to eq(right_format)
    end
  end
end
