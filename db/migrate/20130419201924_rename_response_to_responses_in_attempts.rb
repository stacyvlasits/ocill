class RenameResponseToResponsesInAttempts < ActiveRecord::Migration
  def change
    rename_column :attempts, :response, :responses
  end
end
