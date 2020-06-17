require './lib/game'
require './lib/file_helper'
require './lib/data'
require './bin/printer'

RSpec.describe 'Zero Score Scenario' do
  describe 'zero scenario' do
    before(:each) do
      file = FileHelper.read('./spec/fixtures/all_0.txt')
      data = GameData.new(file)
      data.format("\t")
      @game = Game.new(data.players)
      @game.make_throws(data)
    end

    it 'scores zero scenario. all failed.' do
      zero_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      expect(@game.lanes[0].frames.map(&:score)).to eq(zero_scores)
    end

    it 'print in the right format with right data' do
      right_format = "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nCarl\n"
      right_format += "Pinfalls\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t\n"
      right_format += "Score\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\n"
      expect(Printer.print(@game)).to eq(right_format)
    end
  end
end
