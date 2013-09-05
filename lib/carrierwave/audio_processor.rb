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
      audio = Panda::Video.create!(:file => file.file, :profiles => "mp3", :path_format => "fuck/#{store_dir}/mp3_#{file.filename.split(".").first}" )
    end
    def encode_as_ogg
      audio = Panda::Video.create!(:file => file.file, :profiles => "vorbis", :path_format => "fuck/#{store_dir}/ogg_#{file.filename.split(".").first}")
    end
  end
end