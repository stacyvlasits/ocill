class RenameColumnNamesToHeaderRow < ActiveRecord::Migration
  def up
    rename_column :drills, :column_names, :header_row
  end

  def down
    rename_column :drills, :header_row, :column_names
  end
end
