require_relative 'goals_to_points_convertor'

class RankingTable
  attr_reader :rows

  def initialize
    @rows = []
  end

  def add_match_result(result)
    first_team_pts, second_team_pts = *GoalsToPointsConverter.convert(
      result.first_team[:goals], result.second_team[:goals]
    )
    get_or_add_row(result.first_team[:name]).add_points first_team_pts
    get_or_add_row(result.second_team[:name]).add_points second_team_pts
  end

  def print
    @rows.each_with_index do |row, i|
      puts "#{i+1}. #{row.team_name}, #{row.points} " +
           "#{row.points == 1 ? 'pt' : 'pts'}"
    end
  end

  def sort_rows
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
      row = @rows.find { |r| r.team_name == team_name }
      unless row
        row = Row.new(team_name)
        @rows.push row
      end
      row
    end
end
