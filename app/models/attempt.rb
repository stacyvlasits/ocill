class Attempt < ActiveRecord::Base
  attr_accessible :drill_id, :user_id
  has_many :responses
  belongs_to :drill
  belongs_to :user
  accepts_nested_attributes_for :responses, allow_destroy: true

  def correct
    gradesheet.select {|el| el[0] == el[1] }.count
  end

  def incorrect
    grade_sheet.count - correct
  end

  def grade_sheet
    responses.each_with_index.map { |response, index| [response.value, response.answer] }
  end

  def answers
    self.responses.answer
  end
end
