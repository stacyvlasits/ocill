class CreateMediaItems < ActiveRecord::Migration
  def change
    create_table :media_items do |t|
      t.string :name
      t.string :url
      t.string :type

      t.timestamps
    end
  end
end
