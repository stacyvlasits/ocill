class Response < ActiveRecord::Base
  attr_accessible :attempt_id, :exercise_item_id, :value

  belongs_to :attempt
  belongs_to :exercise_item

  def answers
    self.exercise_item.answers
  end

  def correct?
    answers.include?(self.value)
  end

  alias :credit? :correct?
end
