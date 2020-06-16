RSpec.describe Lane do
  let(:lane) { Lane.new(Player.new) }
  let(:laneInterfaced) { LaneInterface.new(Lane.new(Player.new)) }

  describe '#initialize' do
    it 'returns Lane object of the class Lane and works with interface' do
      expect(lane).to be_an(Lane)
      expect(laneInterfaced).to be_an(LaneInterface)
    end
  end

  describe '#throw' do
    it 'sets a throw in the current_frame if is available' do
      expect(lane.current_frame.get_values).to eq([])
      lane.throw(5)
      expect(lane.current_frame.get_values).to eq([5])
    end

    it 'sets a trow in the next frame if is first is not available.' do
      expect(lane.current_frame.get_values).to eq([])
      lane.throw(5)
      lane.throw(5)
      expect(lane.current_frame.get_values).to eq([5, 5])
      lane.throw(5)
      expect(lane.current_frame.get_values).to eq([5])
      expect(lane.frames[0].get_values).to eq([5, 5])
      expect(lane.frames[1].get_values).to eq([5])
    end
  end

  describe '#score' do
    it 'sets a basic non spare score' do
      expect(lane.frames[0].get_values).to eq([])
      expect(lane.frames[0].score).to_not be_truthy
      lane.throw(3)
      expect(lane.frames[0].score).to_not be_truthy
      lane.throw(4)
      expect(lane.frames[0].score).to eq(7)
    end

    it 'sets a spare and a five' do
      expect(lane.frames[0].get_values).to eq([])
      lane.throw(5)
      lane.throw(5)
      expect(lane.frames[0].get_values).to eq([5, 5])
      expect(lane.frames[0].score).to_not be_truthy
      lane.throw(5)
      expect(lane.frames[0].score).to eq(15)
    end

    it '3 strikes scenario' do
      expect(lane.frames[0].get_values).to eq([])
      lane.throw(10)
      expect(lane.frames[0].get_values).to eq([10])
      expect(lane.frames[0].score).to_not be_truthy
      lane.throw(10)
      expect(lane.frames[0].score).to_not be_truthy
      lane.throw(10)
      expect(lane.frames[0].score).to eq(30)
    end

    it 'strike and spare scenario' do
      expect(lane.frames[0].get_values).to eq([])
      lane.throw(10)
      lane.throw(5)
      expect(lane.frames[0].get_values).to eq([10])
      expect(lane.frames[0].score).to_not be_truthy
      lane.throw(5)
      expect(lane.frames[0].score).to eq(20)
    end

    it 'strike and non spare scenario' do
      expect(lane.frames[0].get_values).to eq([])
      lane.throw(10)
      lane.throw(1)
      expect(lane.frames[0].score).to_not be_truthy
      lane.throw(1)
      expect(lane.frames[0].score).to eq(12)
      expect(lane.frames[1].score).to eq(14)
    end
  end
end
