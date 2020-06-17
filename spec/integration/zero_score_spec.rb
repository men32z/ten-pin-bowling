require './lib/game'
require './lib/file_helper'
require './lib/data'
require './bin/printer'

RSpec.describe 'Zero Score Scenario' do
  describe 'zero scenario' do
    before(:each) do
      file = FileHelper.read('./spec/fixtures/all_0.txt')
      data = GameData.new(file)
      data.format(' ')
      @game = Game.new(data.players)
      @game.make_throws(data)
    end

    it 'scores zero scenario. all failed.' do
      zero_scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      expect(@game.lanes[0].frames.map(&:score)).to eq(zero_scores)
    end

    it 'print in the right format with right data' do
      right_format = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t\nCarl\n"
      right_format += "Pinfalls 0 0\t0 0\t0 0\t0 0\t0 0\t0 0\t0 0\t0 0\t0 0\t0 0 \n"
      right_format += "Score\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t\n"
      expect(Printer.print(@game)).to eq(right_format)
    end
  end
end
