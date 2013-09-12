class AddPandaAudioIdToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :panda_audio_id, :string
  end
end
