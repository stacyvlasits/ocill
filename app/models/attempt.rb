class Attempt < ActiveRecord::Base
  attr_accessible :drill_id, :user_id, :responses_attributes
  has_many :responses
  belongs_to :drill
  belongs_to :user
  accepts_nested_attributes_for :responses, allow_destroy: true

  def score
    '<span class="score">' + correct.to_s + ' out of ' + total.to_s + '</span>'
  end

  def correct
    correct = grade_sheet.select do |el|
      # binding.pry
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

  def answers
    self.responses.answer
  end
end
