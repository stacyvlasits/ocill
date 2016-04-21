class Attempt < ActiveRecord::Base
  attr_accessible :drill_id, :user_id, :lis_outcome_service_url, :lis_result_sourcedid, :response, :responses

  has_many :exercise_items, :through => :drill
  belongs_to :drill
  belongs_to :user
  default_scope :include => :exercise_items
  serialize :response, JSON

  # TODO move the presentation of the score out of the model and into a view helper
  def html_score
    '<span class="score"><span class="correct">' + correct.to_s + '</span>/<span class="total">' + total.to_s + '</span></span>'.html_safe
  end

  def responses
    self.response = Responses.new(self.response || 0)
  end

  def responses=(*args)
    self.response = Responses.new(*args)
  end

  def matches_current_drill_state?
    broken_responses = self.responses.select do |r|
      !self.exercise_item_ids.include?(r.exercise_item_id.to_i)
    end
    broken_responses.empty?
  end

  def decimal_score
    (correct.to_f / total.to_f).round(2)
  end

  #TODO: use or remove
  def percent_score
    return 0 if total == 0
    correct / total
  end

  def correct_responses
    responses.select {|response| correct_ids.include?(response.exercise_item_id)}
  end

  def correct
    correct_ones.count
  end

  def course
    self.drill.course
  end

  def incorrect
    total - correct
  end

  def total
    grade_sheet.select { |el| el[1].present? }.count
  end

  def answers
    responses.map{ |r| r.exercise_item.answers}.flatten
  end

  def grade_sheet
    responses.each_with_index.map do |response, index|
      answers = response.exercise_item ? response.exercise_item.answers : []
      [response.value, answers , response.exercise_item_id]
    end
  end

  def correct_ones
    grade_sheet.select do |el|
      el[1].include?(el[0].to_s) if el[1].respond_to?(:include?)
    end
  end

  def correct_ids
    correct_ones.map {|array| array[2] }
  end

  def exercise_item_ids
    self.exercise_items.map { |ei| ei['id']  }
  end
end
