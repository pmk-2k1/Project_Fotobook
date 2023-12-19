class Admin::PhotosController < ApplicationController
  def index
    @photos = Photo.all.page(params[:page]).per(12)
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :is_private, :image)
  end
end
