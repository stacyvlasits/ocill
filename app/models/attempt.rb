class Attempt < ActiveRecord::Base
  attr_accessible :drill_id, :user_id, :responses_attributes, :lis_outcome_service_url, :lis_result_sourcedid, :response
  has_many :responses, :dependent => :destroy, :autosave => true, :include => :exercise_item
  has_many :exercise_items, :through => :responses
  belongs_to :drill
  belongs_to :user
  accepts_nested_attributes_for :responses, allow_destroy: true
  default_scope :include => :exercise_items, :include => :responses
  serialize :response, JSON
  # TODO move the presentation of the score out of the model and into a view helper
  def html_score
    '<span class="score"><span class="correct">' + correct.to_s + '</span>/<span class="total">' + total.to_s + '</span></span>'.html_safe
  end

  def matches_current_drill_state?
    broken_responses = self.responses.includes(:exercise_item).select do |r|
      r.exercise_item == nil
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

  def correct_ones
    correct = grade_sheet.select do |el|
      el[1].include?(el[0].to_s) if el[1].respond_to?(:include?)
    end
  end

  def correct_ids
    correct_ones.map {|array| array[2] }
  end

  def correct_responses
    r = responses.select {|response| correct_ids.include?(response.id)}
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

  def grade_sheet
    responses.each_with_index.map do |response, index|
      answers = response.exercise_item ? response.exercise_item.answers : []
      [response.value, answers , response.id]
    end
  end

  def answers
    responses.map{ |r| r.exercise_item.answers}.flatten
  end
end
