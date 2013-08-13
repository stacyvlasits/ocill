class Attempt < ActiveRecord::Base
  attr_accessible :drill_id, :user_id, :responses_attributes
  has_many :responses
  belongs_to :drill
  belongs_to :user
  accepts_nested_attributes_for :responses, allow_destroy: true

  # TODO move the presentation of the score out of the model and into a view helper
  def score
    '<span class="score"><span class="correct">' + correct.to_s + '</span>/<span class="total">' + total.to_s + '</span></span>'
  end

  def correct
    correct = grade_sheet.select do |el|
      el[1].include?(el[0].to_s) if el[1].respond_to?(:include?)
    end
    correct.count
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
    responses.each_with_index.map { |response, index| [response.value, response.answers] }
  end

  def percent
    correct / total
  end

  def answers
    # pretty sure this method is worthless.  wrote it anyway
    responses.map{|r| r.answers}.flatten
  end
end
