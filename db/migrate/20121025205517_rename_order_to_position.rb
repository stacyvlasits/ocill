class RenameOrderToPosition < ActiveRecord::Migration
  def change
    rename_column :lessons, :order, :position    
    rename_column :courses, :order, :position    
    rename_column :exercises, :order, :position    
    rename_column :exercise_items, :order, :position    
  end
end
