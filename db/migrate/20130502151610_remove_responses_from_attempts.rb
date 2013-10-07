class RemoveResponsesFromAttempts < ActiveRecord::Migration
  def up
    remove_column :attempts, :responses
  end

  def down
    add_column :attempts, :responses, :text
  end
end
