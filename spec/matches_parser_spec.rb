require 'rspec'
require_relative '../app/matches_parser'

describe MatchesParser do
  let(:parser) do
    MatchesParser.new("#{__dir__}/files/input_for_matches_parser.txt")
  end

  describe 'parse_match_result' do
    context 'method is called multiple times' do
      it 'returns matches results untill parse all of them' do
        results = [{
          first_team: { name: 'Snakes', goals: 3 },
          second_team: { name: 'Lions', goals: 3 }
        },
        {
          first_team: { name: 'Lions', goals: 2 },
          second_team: { name: 'FC Awesome', goals: 3 }
        },
        {
          first_team: { name: 'Snakes', goals: 0 },
          second_team: { name: 'FC Awesome', goals: 1 }
        }]
        i = 0

        while result = parser.parse_match_result
          expect(result.first_team).to eq results[i][:first_team]
          expect(result.second_team).to eq results[i][:second_team]
          i += 1
        end
      end
    end

    context 'all matches results are parsed' do
      before { 3.times { parser.parse_match_result } }

      it 'returns nil' do
        expect(parser.parse_match_result).to eq nil
      end
    end
  end
end
