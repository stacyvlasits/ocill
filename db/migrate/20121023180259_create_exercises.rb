class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :title
      t.decimal :weight
      t.text :prompt
      t.text :column_names
      t.integer :order

      t.timestamps
    end
  end
end
