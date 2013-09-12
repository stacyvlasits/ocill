class PandaController < ApplicationController
  skip_before_filter :authenticate_user!

  def notifications
    if params[:event] == 'video-encoded'
        model = Exercise.find_by_panda_audio_id(params[:video_id])
        model ||= ExerciseItem.find_by_panda_audio_id(params[:video_id]) 
        
        if model
          if model.panda_audio.status == 'fail'
            #  TODO insert error handling?
          else
            mp3 = model.panda_audio.encodings['mp3']
            ogg = model.panda_audio.encodings['ogg']

            if mp3.status == 'success'
              model.mp3 = mp3.url

            else
              model.mp3_errors = "Something went wrong while uploading please email the url of this page to #{ENV["SUPPORT_EMAIL"]}"
            end

            if ogg.status == 'success'
                model.ogg = ogg.url
            else 
              model.ogg_errors = "Something went wrong while uploading please email the url of this page to #{ENV["SUPPORT_EMAIL"]}"
            end
          end
          model.save!

        else
            #  TODO insert error handling?
        end
    end
    render nothing: true
  end
end
