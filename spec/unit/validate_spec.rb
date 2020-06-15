# frozen_string_literal: true

RSpec.describe Validate do
  describe '#initialize' do
    it 'returns Validate object of the class Validate' do
      validator = Validate.new(5, 'min:0|max:10|number')
      expect(validator).to be_an(Validate)
    end
  end

  describe '#methods' do
    it 'min method works' do
      validator = Validate.new(5, 'min:0')
      expect(validator.valid?).to be_truthy
      validator2 = Validate.new(-5, 'min:0')
      expect(validator2.valid?).to_not be_truthy
    end

    it 'max method works' do
      validator = Validate.new(10, 'max:10')
      expect(validator.valid?).to be_truthy
      validator2 = Validate.new(6, 'max:5')
      expect(validator2.valid?).to_not be_truthy
    end

    it 'number method works' do
      validator = Validate.new(10, 'number')
      expect(validator.valid?).to be_truthy
      validator2 = Validate.new('A', 'number')
      expect(validator2.valid?).to_not be_truthy
    end
  end

  describe 'bad cases' do
    it 'not allowed methods are ignored' do
      validator = Validate.new(5, 'min:0|max:10|number|fake_method')
      expect(validator.valid?).to be_truthy
    end

    it 'empty methods are ignored' do
      validator = Validate.new(-8, 'min:0|max:10|number||||')
      expect(validator.valid?).to_not be_truthy
    end
  end
end
