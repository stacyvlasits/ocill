class ListeningDrill < Drill
  validates_presence_of :column_names  

#this code makes sti routing and pathing work
  def self.model_name
    Drill.model_name
  end
end