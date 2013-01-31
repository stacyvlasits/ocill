class ListeningExerciseItem < ExerciseItem

  def content
    content[:text] = self.text

  end
end