class AddImageToMediaItems < ActiveRecord::Migration
  def change
    add_column :media_items, :image, :string
  end
end
