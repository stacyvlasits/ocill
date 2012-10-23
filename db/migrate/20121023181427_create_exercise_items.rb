class CreateExerciseItems < ActiveRecord::Migration
  def change
    create_table :exercise_items do |t|
      t.string :text
      t.boolean :scored
      t.string :type

      t.timestamps
    end
  end
end
