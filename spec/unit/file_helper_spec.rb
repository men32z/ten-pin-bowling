# frozen_string_literal: true

require './lib/file_helper'

RSpec.describe FileHelper do
  describe '#read' do
    it 'reads a valid file' do
      file = FileHelper.read('./spec/fixtures/example.txt')
      expect(file[0]).to eq('Jeff 10')
      expect(file[1]).to eq('John 3')
    end

    it "reads a file that doesn't exist" do
      file = FileHelper.read('fake_route')
      expect(file).to eq(false)
    end
  end
end
