class AddTypeToDrills < ActiveRecord::Migration
  def change
    add_column :drills, :type, :string
  end
end
