require 'rspec'
require_relative '../app/goals_to_points_convertor'

describe GoalsToPointsConverter do
  let(:converter) { GoalsToPointsConverter }

  describe '.convert' do
    context 'the first argument is bigger than the second' do
      it 'returns [3,0] array' do
        expect(converter.convert(2, 0)).to eq [3,0]
      end
    end

    context 'the first argument is equal the second' do
      it 'returns [1,1] array' do
        expect(converter.convert(1, 1)).to eq [1,1]
      end
    end

    context 'the first argument is less the second' do
      it 'returns [0,3] array' do
        expect(converter.convert(0, 2)).to eq [0,3]
      end
    end
  end
end
