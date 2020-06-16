RSpec.describe Frame do
  let(:onlyframe) { Frame.new }
  let(:frame) { FrameInterface.new(Frame.new) }
  let(:frame2) { FrameInterface.new(Frame.new) }
  let(:frame3) { FrameInterface.new(Frame.new) }
  describe '#initialize' do
    it 'returns frame object of the class Frame and works with interface' do
      expect(onlyframe).to be_an(Frame)
      expect(frame).to be_an(FrameInterface)
    end
  end

  describe '#shoot' do
    it 'has minimun 0 and max 10, validations' do
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(0)).to be_truthy
      expect(frame.get_values).to eq([5, 0])

      expect(frame2.shoot(11)).to_not be_truthy
      expect(frame2.shoot(-1)).to_not be_truthy
      expect(frame2.get_values).to eq([])

      expect(frame3.shoot(10)).to be_truthy
      expect(frame3.get_values).to eq([10])
    end

    it 'should show F as 0' do
      expect(frame.shoot('F')).to be_truthy
      expect(frame.get_values).to eq([0])
    end

    it 'should have a max of 10 points per frame' do
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(6)).to_not be_truthy
      expect(frame.get_values).to eq([5])
      expect(frame.shoot(5)).to be_truthy
      expect(frame.get_values).to eq([5, 5])
    end
  end

  describe '#available_trows?' do
    it "returns true if we haven't  shoot" do
      expect(frame.available_trows?).to be_truthy
    end
    it 'returns true if we have one shoot' do
      frame.shoot(5)
      expect(frame.available_trows?).to be_truthy
    end
    it 'returns false if we have two shoots and they are spare' do
      frame.shoot(5)
      frame.shoot(5)
      expect(frame.available_trows?).to_not be_truthy
    end
    it 'returns false if we have two shoots and they are not spare' do
      frame.shoot(5)
      frame.shoot(4)
      expect(frame.available_trows?).to_not be_truthy
    end

    it 'returns false if we have one strike' do
      frame.shoot(10)
      expect(frame.available_trows?).to_not be_truthy
    end
  end

  describe '#max_next_value' do
    it 'returns 4 if we have 6 in the first shoot' do
      frame.shoot(6)
      expect(frame.max_next_value).to eq(4)
    end

    it 'returns 8 if we have 2 in the first shoot' do
      frame.shoot(2)
      expect(frame.max_next_value).to eq(8)
    end

    it 'returns 0 if we have 10 in the first shoot' do
      frame.shoot(10)
      expect(frame.max_next_value).to eq(0)
    end
  end
end
