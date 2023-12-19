class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update destroy]
  # skip_before_action :authenticate_user!, only: [:guest, :guest_album]


  def index
    @user = User.find(params[:user_id])
    if params[:user_id] == current_user.id
      @user =current_user
    end
    @is_current = params[:user_id].to_i == current_user.id ? true : false
  end

  def show
  end

  def new
    @photo = current_user.photos.new()
  end

  def edit
  end

  def create

    @photo = current_user.photos.new(photo_params)
    if @photo.save
      # redirect_to @photo
      # redirect_to action: :index
      redirect_to user_photos_path(current_user)
    else
      render "new"
    end
  end

  def update
    # respond_to do |format|
    if @photo.update(photo_params)
      if current_user.admin?
        redirect_to admin_photos_path
      else
        redirect_to user_photos_path(current_user)
      end
    else
      render :index
    end
    # end
  end

  def destroy
    @photo.destroy
    if current_user.admin?
      redirect_to admin_photos_path
    else
      # respond_to do |format|
      redirect_to user_photos_path(current_user)
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :is_private, :image)
  end
end
