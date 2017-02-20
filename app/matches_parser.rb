class MatchesParser
  attr_reader :content, :line_index

  MatchResult = Struct.new(:first_team, :second_team)

  def initialize(path)
    @content = File.readlines(path)
    @content.pop if @content[-1].strip.empty?
    @line_index = 0
  end

  def parse_match_result
    line = content[line_index]
    if line.nil?
      nil
    else
      self.line_index = line_index + 1
      parse line
    end
  end

  private

    attr_writer :line_index

    def parse(line)
      ary = line.split(',').map(&:strip)

      first_team_goals  = ary[0][/\d+\z/].to_i
      second_team_goals = ary[1][/\d+\z/].to_i
      first_team_name   = ary[0].sub(/\s*\d+\z/, '')
      second_team_name  = ary[1].sub(/\s*\d+\z/, '')

      MatchResult.new(
        { name: first_team_name, goals: first_team_goals },
        { name: second_team_name, goals: second_team_goals }
      )
    end
end
