class CreateHeaders < ActiveRecord::Migration
  def change
    create_table :headers do |t|
      t.integer :drill_id
      t.string :title
      t.integer :position
      t.string :exercise_item_id

      t.timestamps
    end
  end
end
