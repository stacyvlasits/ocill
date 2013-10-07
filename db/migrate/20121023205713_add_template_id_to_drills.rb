class AddTemplateIdToDrills < ActiveRecord::Migration
  def change
    add_column :drills, :template_id, :integer
  end
end
