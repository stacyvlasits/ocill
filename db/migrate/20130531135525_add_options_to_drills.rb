class AddOptionsToDrills < ActiveRecord::Migration
  def change
    add_column :drills, :options, :text
  end
end
