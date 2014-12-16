class NumberwangService
  ThatsNumberwang = Class.new(StandardError)
  ThatsWangernumb = Class.new(StandardError)

  def initialize(wangernumb_round: false)
    @wangernumb_round = wangernumb_round
    @chosen_numbers = []
  end

  def choose(*x)
    x.each do |expr|
      expr = normalize_expression(expr)
      @chosen_numbers << expr

      if @wangernumb_round && found_wangernumb?
        raise ThatsWangernumb
      elsif found_numberwang?
        raise ThatsNumberwang
      end
    end
  end

  private

  def found_numberwang?
    case @chosen_numbers.last
    when '8-4', '109*17' then return true
    when 4 then
      return true if @chosen_numbers.size > 1
    end

    last_two_numbers = @chosen_numbers[-2..-1]
    case last_two_numbers
    when [18, 54], [6, 2.4], ['root14', 12] then true
    end
  end

  def found_wangernumb?
    if last_eight = @chosen_numbers[-8..-1]
      last_eight.uniq == [1]
    end
  end

  def normalize_expression(expr)
    if expr.respond_to?(:gsub)
      expr.gsub(/\s/, '')
    else
      expr
    end
  end
end
