class AddExportIdToSection < ActiveRecord::Migration
  def change
    add_column :sections, :export_id, :string
  end
end
