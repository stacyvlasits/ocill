# TODO Remove this file.  I don't think it's used anymore
module CarrierWave
  module AudioProcessor
    module ClassMethods
      def encode_as_mp3
        process :encode_as_mp3
      end
      def encode_as_ogg
        process :encode_as_ogg
      end
    end

    def encode_as_mp3
      new_filename = remove_audio_ext(file.filename) + ".mp3"
      audio = Panda::Video.create!(:file => file.file, :profiles => "mp3", :path_format => "#{store_dir}/#{new_filename}" )
    end
    def encode_as_ogg
      new_filename = remove_audio_ext(file.filename) + ".ogg"
      audio = Panda::Video.create!(:file => file.file, :profiles => "ogg", :path_format => "#{store_dir}/#{new_filename}")
    end

    def remove_audio_ext(path_and_file)
      path_and_file.sub(/\.ogg$|\.oga$|\.mp3$|\.wav$|\.m4a$/i, '')
    end
  end
end