class WordProblem

  OPERATORS = { 'plus' => '+', 'minus' => '-', 'multiplied by' => '*', 'divided by' => '/' }
  REG = { number: '(?<number>-*\d+)',
          operator: '(?<operator>[a-z\s]+)',
          more: '(?<more>[\w\s-]*)' }

  def initialize(question)
    @question = question
  end

  def answer
    # Example: "What is -14 multiplied by 234 ...?"

    # Parse the first number and the rest
    matched = @question.match(/What is #{REG[:number]}#{REG[:more]}?/)
    raise ArgumentError unless matched
    
    number = matched[:number].to_i
    more = matched[:more]

    @answer = number
    add_operation(more)

    @answer
  end

  private

# Add the rest of the operation to our answer
  def add_operation(more)
    # Example: " divided by -3 ...?"

    matched = more.match(/ #{REG[:operator]} #{REG[:number]}#{REG[:more]}/)
    raise ArgumentError unless matched

    operator = OPERATORS[matched[:operator]]
    number = matched[:number].to_i
    more = matched[:more]

    @answer = @answer.send operator, number

    if (more != "")
      add_operation(more)
    end
  end
end
