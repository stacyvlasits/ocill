class ListeningDrill < Drill


#this code makes sti routing and pathing work
  def self.model_name
    Drill.model_name
  end
end