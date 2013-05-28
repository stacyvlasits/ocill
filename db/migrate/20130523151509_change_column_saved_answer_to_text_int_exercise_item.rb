class ChangeColumnSavedAnswerToTextIntExerciseItem < ActiveRecord::Migration
  def up
    rename_column :exercise_items, :saved_answer, :acceptable_answers
    change_column :exercise_items, :acceptable_answers, :text
  end

  def down
    change_column :exercise_items, :acceptable_answers, :string
    rename_column :exercise_items, :acceptable_answers, :saved_answer
  end
end
