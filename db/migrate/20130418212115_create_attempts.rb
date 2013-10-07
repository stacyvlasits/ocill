class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :answer_id
      t.text :response

      t.timestamps
    end
  end
end
