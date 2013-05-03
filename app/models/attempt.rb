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
    grade_sheet.select {|el| el[0] == el[1] }.count
  end

  def incorrect
    total.count - correct
  end

  def total
    grade_sheet.count
  end

  def grade_sheet
    responses.each_with_index.map { |response, index| [response.value, response.answer] }
  end

  def answers
    self.responses.answer
  end
end
