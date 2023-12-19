class AlbumsController < ApplicationController
  before_action :set_album, only: %i[show edit update destroy]

  def index
    @albums = Album.all
    @user = User.find(params[:user_id])
    if params[:user_id] == current_user.id
      @user =current_user
    end
    @is_current = params[:user_id].to_i == current_user.id ? true : false
  end

  def new
    @album = current_user.albums.new()
  end

  def show
  end

  def edit
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      # redirect_to @album
      # redirect_to action: :index
      redirect_to user_albums_path(current_user)
    else
      render "new"
    end
  end

  def update
    # respond_to do |format|
    if @album.update(album_params)
      if current_user.admin?
        redirect_to admin_albums_path
      else
        redirect_to user_albums_path(current_user)
      end
    else
      render :index
    end
    # end
  end

  def destroy
    @album.destroy
    if current_user.admin?
      redirect_to admin_albums_path
    else
      # respond_to do |format|
      redirect_to user_albums_path(current_user)
    # end
    end
  end

  private
  def set_album
    @album = Album.find(params[:id])
  end
  def album_params
    params.require(:album).permit(:title, :description, :is_private, {images:[]})
  end
end
