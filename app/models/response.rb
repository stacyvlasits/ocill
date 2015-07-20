class Response < Hash
  attr_accessor :exercise_item_id, :attempt_id, :value, :cached_exercise_item

  def initialize(response=nil)
    self.exercise_item_id = self["exercise_item_id"] = response ? response["exercise_item_id"] : nil
    self.value = self["value"] =  response ? response["value"] : nil
  end

  def attempt
    if self.attempt_id
      begin
        Attempt.unscoped.find(self.attempt_id)
      rescue ActiveRecord::RecordNotFound
        #TODO:  Do nothing?
      end
    else
      nil
    end
  end

  def exercise_item
    if @cached_exercise_item
      @cached_exercise_item
    elsif self.exercise_item_id
      begin
        @cached_exercise_item = ExerciseItem.unscoped.find(self.exercise_item_id)
      rescue ActiveRecord::RecordNotFound
      end
    else
      nil
    end
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
