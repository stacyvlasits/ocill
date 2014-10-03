class DragDrill < Drill
  def self.model_name
    Drill.model_name
  end

  def as_json(options={})
    if options[:type] == :simple
      { 
        id: self.id,
        unit_id: self.unit_id ,         
        exercises: self.exercises.as_json({ type: :DragDrill })
      }      
    else
      { 
        id: self.id , 
        instructions: self.instructions , 
        prompt: self.prompt , 
        position: self.position , 
        options:  self.options , 
        title: self.title , 
        unit_id: self.unit_id , 
        exercises: self.exercises.as_json({ type: :DragDrill })
       }
    end
  end
end