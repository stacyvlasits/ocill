class ChangeColumnResponseValueToText < ActiveRecord::Migration
  def up
    change_column :responses, :value, :text
  end

  def down
    change_column :responses, :value, :string
  end
end
