class Response < ActiveRecord::Base
  attr_accessible :attempt_id, :exercise_item_id, :value

  belongs_to :attempt
  belongs_to :exercise_item

  def correct_answer
    self.exercise_item.answer
  end

  def correct?
    self.value == self.exercise_item.answer
  end
  alias :credit? :correct?
end
