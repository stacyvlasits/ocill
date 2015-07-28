# encoding: utf-8

class AudioUploader < CarrierWave::Uploader::Base
  after :store, :panda_encode
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  
  include Sprockets::Rails::Helper
  #  include CarrierWaveDirect::Uploader
  # Choose what kind of storage to use for this uploader:

  include CarrierWave::MimeTypes
  process :set_content_type
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}#{model.created_at.to_s.parameterize}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    asset_path("/fallback/" + [version_name, "default.m4a"].compact.join('_'))
  end


  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(m4a wav mp3 ogg oga)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      downcased = original_filename.sub(/(\.\w\w\w)$/){|m| m.downcase}
    end
  end

private
  def panda_encode(*args)
    audio=Panda::Video.create!(:source_url => url, :path_format => "#{store_dir}/#{remove_audio_ext(filename)}", :profiles => "mp3,ogg")
    model.panda_audio_id = audio.id
    model.save!
  end

  def remove_audio_ext(path_and_file)
    path_and_file.sub(/\.ogg$|\.oga$|\.mp3$|\.wav$|\.m4a$/i, '')
  end  
end
