class RenameMediaItemTypetoTypeInMediaItem < ActiveRecord::Migration
  def up
    rename_column :media_items, :media_item_type, :type
  end

  def down
    rename_column :media_items, :type, :media_item_type
  end
end
