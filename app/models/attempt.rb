class Attempt < ActiveRecord::Base
  attr_accessible :drill_id, :responses, :user_id
  serialize :responses
  belongs_to :drill
  belongs_to :user

  before_validation :parse_responses

  def parse_responses
    self.responses = self.responses.split("&&&")
  end

  def correct
    graded_responses.select {|response| response == true }.count
  end

  def incorrect
    graded_responses.count - correct
  end

  def graded_responses
    answers.each_with_index.map { |answer, index| (answer == responses[index]) || answer }
  end

  def answers
    self.drill.answers
  end
end
