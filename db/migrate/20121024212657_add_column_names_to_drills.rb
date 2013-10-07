class AddColumnNamesToDrills < ActiveRecord::Migration
  def change
    add_column :drills, :column_names, :text
  end
end
