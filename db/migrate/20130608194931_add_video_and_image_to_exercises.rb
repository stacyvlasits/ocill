class AddVideoAndImageToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :video, :string
    add_column :exercises, :image, :string
  end
end
