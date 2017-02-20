module GoalsToPointsConvertor
  def convert(a, b)
    if a > b
      [3, 0]
    elsif a == b
      [1, 1]
    else
      [0, 3]
    end
  end

  module_function :convert
end
