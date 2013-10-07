class RenameOrderToPositionInDrills < ActiveRecord::Migration
  def change
    rename_column :drills, :order, :position
  end
end
