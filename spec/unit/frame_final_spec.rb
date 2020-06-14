require './lib/frame_final'
require './lib/frame_interface'

RSpec.describe FrameFinal do
  let(:onlyframe ) { FrameFinal.new }
  let(:frame) { FrameInterface.new(FrameFinal.new) }
  let(:frame2) { FrameInterface.new(FrameFinal.new) }
  let(:frame3) { FrameInterface.new(FrameFinal.new) }
  describe '#initialize' do
    it 'returns frame object of the class FrameFinal and works with interface' do
      expect(onlyframe).to be_an(FrameFinal)
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

    it "should allow 3 shoots if first 2 are spare" do
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(10)).to be_truthy
      expect(frame.get_values).to eq([5, 5, 10])
    end

    it "should allow 3 strikes" do
      expect(frame.shoot(10)).to be_truthy
      expect(frame.shoot(10)).to be_truthy
      expect(frame.shoot(10)).to be_truthy
      expect(frame.get_values).to eq([10, 10, 10])
    end

    it "should allow strike and two shoots" do
      expect(frame.shoot(10)).to be_truthy
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(4)).to be_truthy
      expect(frame.get_values).to eq([10, 5, 4])
    end

    it "should allow strike and spare" do
      expect(frame.shoot(10)).to be_truthy
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(5)).to be_truthy
      expect(frame.get_values).to eq([10, 5, 5])
    end

    it "shouldn't allow strike and more than 10 in las two shoots" do
      expect(frame.shoot(10)).to be_truthy
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(6)).to_not be_truthy
      expect(frame.get_values).to eq([10, 5])
    end

    it "should allow just 2 shoots if they are less than 10" do
      expect(frame.shoot(5)).to be_truthy
      expect(frame.shoot(4)).to be_truthy
      expect(frame.shoot(10)).to_not be_truthy
      expect(frame.get_values).to eq([5, 4])
    end
  end
end