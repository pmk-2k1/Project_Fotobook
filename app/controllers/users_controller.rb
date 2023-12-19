class UsersController < ApplicationController

  def feed
    @users_fl_photo = current_user.followings
  end

  def feed_albums
    @users_fl_album = current_user.followings
  end

  def discover_photos
    @users = User.all
  end

  def discover_albums
    @users = User.all
  end


  def show
    @user_photo = current_user.photos
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     sign_in @user
  #     redirect_to @user
  #   else
  #     render 'session#sign_in'
  #   end
  # end

  # Unfollows a user.
  def unfollow
    @user= User.find(params[:id])
    current_user.followings.destroy(@user)
    redirect_back(fallback_location: followings_user_path(current_user.id))

  end

  def follow
    @user = User.find(params[:id])
    current_user.followers << @user
    redirect_back(fallback_location: followings_user_path(current_user.id))
    @user_fl = User.find(params[:user_id])
    if params[:user_id] == current_user.id
      @user_fl =current_user
    end
  end


  def followings
    @user = User.find(params[:id])
    if params[:id] == current_user.id
      @user = current_user
    end
    @is_current = params[:id].to_i == current_user.id ? true : false

  end

  def followers
    @user = User.find(params[:id])
    if params[:id] == current_user.id
      @user = current_user
    end
    @is_current = params[:id].to_i == current_user.id ? true : false

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :admin, :reset_password_token, :avatar,
                                 :current_password, :password_confirmation)
  end
end
