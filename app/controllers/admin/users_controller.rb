class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path if current_user.admin?
  end

  def edit
    @user = User.find(params[:id])
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
