require 'rspec'
require_relative '../app/matches_parser'
require_relative '../app/ranking_table'

describe RankingTable do
  let(:parser) do
    MatchesParser.new("#{__dir__}/files/input_for_matches_parser.txt")
  end
  let(:matches_results) { 3.times.map { parser.parse_match_result } }
  let(:table) { RankingTable.new }

  describe '#add_match_result' do
    let(:result) { matches_results[0] }

    context "teams of the match don't exist in the table yet" do
      it 'adds teams to the table' do
        expect do
          table.add_match_result result
        end.to change(table.rows, :length).by(2)
      end

      it 'calculates their points' do
        table.add_match_result result
        row1 = table.rows.find { |r| r.team_name == result.first_team[:name] }
        row2 = table.rows.find { |r| r.team_name == result.second_team[:name] }
        expect(row1.points).to eq 1
        expect(row2.points).to eq 1
      end
    end

    context 'one of the team of the match exist in the table' do
      before { table.add_match_result matches_results[0] }
      let(:result) { matches_results[1] }

      it 'adds one team to the table' do
        expect do
          table.add_match_result result
        end.to change(table.rows, :length).by(1)
      end

      it 'calculates their points' do
        table.add_match_result result
        row1 = table.rows.find { |r| r.team_name == result.first_team[:name] }
        row2 = table.rows.find { |r| r.team_name == result.second_team[:name] }
        expect(row1.points).to eq 1
        expect(row2.points).to eq 3
      end
    end

    context "teams of the match exist in the table" do
      before do
        table.add_match_result matches_results[0]
        table.add_match_result matches_results[1]
      end
      let(:result) { matches_results[2] }

      it 'does not add teams to the table' do
        expect do
          table.add_match_result result
        end.not_to change(table.rows, :length)
      end

      it 'calculates their points' do
        table.add_match_result result
        row1 = table.rows.find { |r| r.team_name == result.first_team[:name] }
        row2 = table.rows.find { |r| r.team_name == result.second_team[:name] }
        expect(row1.points).to eq 1
        expect(row2.points).to eq 6
      end
    end
  end

  describe 'sort' do
    before { matches_results.each { |r| table.add_match_result r } }

    it 'sorts rows by points and team names' do
      sorted_rows = table.rows.sort do |x, y|
        res = y.points <=> x.points
        res == 0 ? x.team_name <=> y.team_name : res
      end
      table.sort_rows
      expect(table.rows).to eq sorted_rows
    end
  end
end
