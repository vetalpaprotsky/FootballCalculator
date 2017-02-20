require_relative 'goals_to_points_convertor'

class RankingTable
  attr_reader :rows

  def initialize
    @rows = []
  end

  def add_match(match)
    first_team_pts, second_team_pts = *GoalsToPointsConvertor.convert(
      match.first_team[:goals], match.second_team[:goals]
    )
    get_or_add_row(match.first_team[:name]).add_points first_team_pts
    get_or_add_row(match.second_team[:name]).add_points second_team_pts
  end

  def print
    @rows.each_with_index do |row, i|
      puts "#{i+1}. #{row.team_name}, #{row.points} " +
           "#{row.points == 1 ? 'pt' : 'pts'}"
    end
  end

  def sort
    @rows.sort! do |x, y|
      res = y.points <=> x.points
      res == 0 ? x.team_name <=> y.team_name : res
    end
  end

  class Row
    attr_reader :team_name, :points

    def initialize(team_name, points = 0)
      @team_name = team_name
      @points = points
    end

    def add_points(n)
      @points += n
    end
  end

  private

    def get_or_add_row(team_name)
      index = @rows.index { |r| r.team_name == team_name }
      unless index
        @rows.push Row.new(team_name)
        index = @rows.length - 1
      end
      @rows[index]
    end
end
