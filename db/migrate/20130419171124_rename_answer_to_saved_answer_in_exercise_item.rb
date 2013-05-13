class RenameAnswerToSavedAnswerInExerciseItem < ActiveRecord::Migration
  def change
    rename_column :exercise_items, :answer, :saved_answer
  end
end
