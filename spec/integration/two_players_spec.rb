require './lib/game'
require './lib/file_helper'
require './lib/data'
require './bin/printer'

RSpec.describe 'Two players Scenario' do
  describe 'two playes scenario' do
    before(:each) do
      file = FileHelper.read('./spec/fixtures/example_default.txt')
      data = GameData.new(file)
      data.format("\t")
      @game = Game.new(data.players)
      @game.make_throws(data)
    end

    it 'two players right scores.' do
      jeff = [20, 39, 48, 66, 74, 84, 90, 120, 148, 167]
      expect(@game.lanes[0].frames.map(&:score)).to eq(jeff)
      john = [16, 25, 44, 53, 82, 101, 110, 124, 132, 151]
      expect(@game.lanes[1].frames.map(&:score)).to eq(john)
    end

    it 'print in the right format with right data' do
      right_format = "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\t\t\nJeff\n"
      right_format += "Pinfalls\t\tX\t7\t/\t9\t0\t\tX\t0\t8\t8\t/\t0\t6\t\tX\t\tX\tX\t8\t1\t\n"
      right_format += "Score\t\t20\t\t39\t\t48\t\t66\t\t74\t\t84\t\t90\t\t120\t\t148\t\t167\n"
      right_format += "John\nPinfalls\t3\t/\t6\t3\t\tX\t8\t1\t\tX\t\tX\t9\t0\t7\t/\t4\t4\tX\t9\t0\t\n"
      right_format += "Score\t\t16\t\t25\t\t44\t\t53\t\t82\t\t101\t\t110\t\t124\t\t132\t\t151\n"
      expect(Printer.print(@game)).to eq(right_format)
    end
  end
end
