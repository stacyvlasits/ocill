class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :exercise_item_id
      t.integer :attempt_id
      t.string :value

      t.timestamps
    end
  end
end
