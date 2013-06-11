class TinymceAssetsController < ApplicationController
  def create
    # Take upload from params[:file] and store it somehow...
    # Optionally also accept params[:hint] and consume if needed
    @image = Image.create(image: params[:file])

    render json: {
      image: {
        url: @image.image_url
      }
    }, content_type: "text/html"
  end
end