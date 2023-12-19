class Admin::AlbumsController < ApplicationController
  def index
    @albums = Album.all.page(params[:page]).per(12)
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :description, :is_private, { images: [] })
  end
end
