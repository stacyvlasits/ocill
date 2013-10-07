class DropTemplateTable < ActiveRecord::Migration
  def up
    drop_table :templates do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
  
  def down
    create_table :templates do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
