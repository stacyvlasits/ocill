class AddParentIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :parent_id, :integer
  end
end
