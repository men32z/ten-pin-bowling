require './lib/game'
require './lib/file_helper'
require './lib/data'
require './bin/printer'

RSpec.describe 'Negative input scenario' do
  describe 'negative input' do
    before(:each) do
      file = FileHelper.read('./spec/fixtures/negative_input.txt')
      data = GameData.new(file)
      data.format("\t")
      @game = Game.new(data.players)
      @game.make_throws(data)
    end

    it 'ignores negative input showing perfect scores.' do
      perfect_scores = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
      expect(@game.lanes[0].frames.map(&:score)).to eq(perfect_scores)
    end

    it 'print in the right format with right data' do
      right_format = "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nCarl\n"
      right_format += "Pinfalls\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX\tX\tX\t\n"
      right_format += "Score\t\t30\t\t60\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270\t\t300\n"
      expect(Printer.print(@game)).to eq(right_format)
    end
  end
end
