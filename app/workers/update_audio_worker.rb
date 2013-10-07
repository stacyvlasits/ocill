# class UpdateAudioWorker
#   include Sidekiq::Worker

#   def perform(id)
#     audio = Exercise.find(id)
#     audio ||= ExerciseItem.find(id)

#     if audio.panda_audio.status == 'fail'
#       #        
#     else

#       binding.pry
#       mp3 = audio.panda_audio.encodings['mp3']
#       ogg = audio.panda_audio.encodings['ogg']

#       if mp3.status == 'success'
#         audio.mp3 = mp3.url

#       else # handle a failed job
#         audio.mp3_errors = "Something went wrong while uploading please email the url of this page to #{ENV["SUPPORT_EMAIL"]}"
#       end

#       if ogg.status == 'success'
#           audio.ogg = ogg.url
#       else 
#         audio.ogg_errors = "Something went wrong while uploading please email the url of this page to #{ENV["SUPPORT_EMAIL"]}"
#       end
#     end
#     audio.save!
#   end
# end
