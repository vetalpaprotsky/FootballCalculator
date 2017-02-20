require_relative 'app/matches_parser'
require_relative 'app/ranking_table'

parser = MatchesParser.new(ARGV[0])
table = RankingTable.new

while result = parser.parse_match_result
  table.add_match_result result
end

table.sort_rows
table.print
