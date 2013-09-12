class AddPandaAudioIdToExerciseItems < ActiveRecord::Migration
  def change
    add_column :exercise_items, :panda_audio_id, :string
  end
end
