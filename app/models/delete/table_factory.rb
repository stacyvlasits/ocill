class TableFactory
  attr_accessor :drill

  def initialize(drill)
    @drill = drill
  end

  def add_column(header_name='Header')
    drill.header_row[header_row.size.to_s] = header_name
    drill.save
    if drill.exercises.empty?
      drill.exercises.create(:title => "Title", :prompt => "Prompt")
    end 
    drill.exercises.each do |exercise|
      exercise.exercise_items.create(:column => header_name)
    end
  end

  def add_row(prompt='Prompt')
    exercise = drill.exercises.create(:title => "Title", :prompt => prompt)
    exercise.make_cells_for_row
  end
end
