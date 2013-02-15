class GridDrill < Drill

 # before_create :set_default_headers
   
   def self.model_name
      Drill.model_name
    end

  def add_column(header_name='Header')
    header = self.headers.create(:title => header_name)
    if self.exercises.empty?
      self.exercises.create(:title => "Title", :prompt => "Prompt")
    end 
    self.exercises.each do |exercise|
      exercise_item = exercise.exercise_items.create(:header_id => header.id)
    end
  end

  def add_row(prompt='Prompt')
    exercise = self.exercises.create(:title => "Title", :prompt => prompt)
    exercise.make_cells_for_row
  end

  def remove_row(exercise_id)
    exercise = self.exercises.find(exercise_id)
    exercise.destroy
  end

  def remove_column(header_id)
    exercise_items = self.exercise_items.where(header_id: header_id) 
    exercise_items.each do |ei|
      ei.destroy
    end
    headers = self.headers.where(id: header_id)
    headers.each do |h|
      h.destroy 
    end
  end
 
  def add_header
    self.header_row[header_row.size.to_s]= "--"
  end


  def columns
    headers.size
  end

  def set_default_headers
    self.headers.create(:title => "Header Title")
    # self.header_row = { "0" => "Exercises", "1" => "First Column" } unless self.header_row.size > 0
  end
end