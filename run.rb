require_relative 'app/matches_parser'
require_relative 'app/ranking_table'

parser = MatchesParser.new(ARGV[0])
table = RankingTable.new

while match = parser.parse_match
  table.add_match match
end

table.sort
table.print
