class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :lti_resource_link_id, index: true
      t.references :section, index: true
      t.references :drill, index: true
      t.timestamps
    end
  end
end
