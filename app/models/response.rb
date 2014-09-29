class Response < ActiveRecord::Base
  attr_accessible :attempt_id, :exercise_item_id, :value
  validates_uniqueness_of :id, :scope => [:exercise_item_id, :attempt_id]

  belongs_to :attempt
  belongs_to :exercise_item
  before_save :strip_value
  default_scope :include => :exercise_item 

  def exercise_item
    if self.exercise_item_id
      begin 
        ExerciseItem.unscoped.find(self.exercise_item_id)
      rescue ActiveRecord::RecordNotFound
        
      end
    else
      nil
    end
  end

  def strip_value
    self.value.strip! if self.value
  end

  def answers
    self.exercise_item.answers if self.exercise_item
  end

  def correct?
    false
    answers.include?(self.value) if answers
  end

  alias :credit? :correct?
end

#create validator for exercise_item_id and attempt_id
