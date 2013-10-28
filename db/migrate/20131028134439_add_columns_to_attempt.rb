class AddColumnsToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :lis_outcome_service_url, :string
    add_column :attempts, :lis_result_sourcedid, :string
    add_index :attempts, :lis_result_sourcedid
  end
end
