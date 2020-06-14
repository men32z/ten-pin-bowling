require './lib/frame'
require './lib/frame_interface'

RSpec.describe Frame do
  let(:onlyframe ) { Frame.new }
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
    it "has minimun 0 and max 10, validations" do
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(0)).to be_truthy
      expect(frame.get_values).to eq([5, 0])

      expect(frame2.shoot(11)).to_not be_truthy
      expect(frame2.shoot(-1)).to_not be_truthy
      expect(frame2.get_values).to eq([])

      expect(frame3.shoot(10)).to be_truthy
      expect(frame3.get_values).to eq([10])
    end

    it "should show F as 0" do
      expect(frame.shoot("F")).to be_truthy
      expect(frame.get_values).to eq([0])
    end

    it "should have a max of 10 points per frame" do
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(6)).to_not be_truthy
      expect(frame.get_values).to eq([5])
      expect(frame.shoot(5)).to be_truthy
      expect(frame.get_values).to eq([5, 5])
    end
  end
end