require './lib/game'
require './lib/file_helper'
require './lib/data'
require './bin/printer'

RSpec.describe 'Two players Scenario' do
  describe 'two playes scenario' do
    before(:each) do
      file = FileHelper.read('./spec/fixtures/example_default.txt')
      data = GameData.new(file)
      data.format(' ')
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
      right_format = "Frame\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t\nJeff\n"
      right_format += "Pinfalls   X\t7 /\t9 0\t  X\t0 8\t8 /\t0 6\t  X\t  X\tX 8 1 \n"
      right_format += "Score\t20\t39\t48\t66\t74\t84\t90\t120\t148\t167\t\n"
      right_format += "John\nPinfalls 3 /\t6 3\t  X\t8 1\t  X\t  X\t9 0\t7 /\t4 4\tX 9 0 \n"
      right_format += "Score\t16\t25\t44\t53\t82\t101\t110\t124\t132\t151\t\n"
      expect(Printer.print(@game)).to eq(right_format)
    end
  end
end
