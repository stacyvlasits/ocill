class AddAudioToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :audio, :string
  end
end
