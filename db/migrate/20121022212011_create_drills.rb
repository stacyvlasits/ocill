class CreateDrills < ActiveRecord::Migration
  def change
    create_table :drills do |t|
      t.string :title
      t.text :prompt
      t.text :instructions
      t.integer :order
      t.integer :responses

      t.timestamps
    end
  end
end
