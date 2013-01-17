class ListeningDrill < Drill
  validates_presence_of :header_row  




#this code makes sti routing and pathing work
  def self.model_name
    Drill.model_name
  end
end