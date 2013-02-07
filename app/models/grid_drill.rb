class GridDrill < Drill

  before_create :set_default_headers


#this code makes sti routing and pathing work
  
  def add_column(header_name='Header')
    # self.header_row[header_row.size.to_s] = header_name
    # self.save
    if self.exercises.empty?
      self.exercises.create(:title => "Title", :prompt => "Prompt")
    end 
    self.exercises.each do |exercise|
      exercise.exercise_items.create(:column => header_name)
    end
  end

  def add_row(prompt='Prompt')
    exercise = self.exercises.create(:title => "Title", :prompt => prompt)
    exercise.make_cells_for_row
  end
 
  def add_header
    self.header_row[header_row.size.to_s]= "--"
  end


  def columns
    header_row.size
  end

  def set_default_headers
    self.headers.create(:title => "Header Title")
    # self.header_row = { "0" => "Exercises", "1" => "First Column" } unless self.header_row.size > 0
  end

  def self.model_name
    Drill.model_name
  end
end