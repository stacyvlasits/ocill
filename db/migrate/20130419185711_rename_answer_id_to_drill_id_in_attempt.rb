class RenameAnswerIdToDrillIdInAttempt < ActiveRecord::Migration
  def change
    rename_column :attempts, :answer_id, :drill_id
  end
end
