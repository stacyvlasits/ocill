class RemoveTemplateIdFromDrills < ActiveRecord::Migration
  def up
    remove_column :drills, :template_id
  end

  def down
    add_column :drills, :template_id, :integer
  end
end
