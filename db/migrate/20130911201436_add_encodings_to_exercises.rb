class AddEncodingsToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :encodings, :text
  end
end
