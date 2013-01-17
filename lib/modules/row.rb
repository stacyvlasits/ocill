class Row
  attr_accessor :exercise

  def initialize(exercise ='')
    @exercise = exercise
  end

  def cells
    cells << row_header
    cells << other_cells
    cells.flatten!
  end

  def row_header
    exercise.prompt
  end

  def other_cells
    
  end

end