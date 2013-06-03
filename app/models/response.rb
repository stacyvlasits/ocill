class Response < ActiveRecord::Base
  attr_accessible :attempt_id, :exercise_item_id, :value
  validates_uniqueness_of :id, :scope => [:exercise_item_id, :attempt_id]

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

#create validator for exercise_item_id and attempt_id
