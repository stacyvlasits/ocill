class PandaController < ApplicationController
  skip_before_filter :authenticate_user!

  def notifications
    if params[:event] == 'video-encoded'
      model = Exercise.where(panda_audio_id: params[:video_id]).first
      model ||= ExerciseItem.where(panda_audio_id: params[:video_id]).first
      
      if model
        if model.panda_audio.status == 'success'

          mp3 = model.panda_audio.encodings['mp3']
          ogg = model.panda_audio.encodings['ogg']

          if mp3.status == 'success'
            model.mp3 = mp3.url
          end

          if ogg.status == 'success'
              model.ogg = ogg.url
          end
        model.save!
        end
      end
    end
    render nothing: true
  end
end
