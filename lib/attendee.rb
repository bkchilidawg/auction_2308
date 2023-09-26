class Attendee
  attr_reader :name, :budget
  def initialize(details)
    @name = details[:name]
    @budget = budget_to_i(details[:budget])
  end

  def budget_to_i(budget_str)
    budget_str.gsub("$", " ").to_i
  end
end