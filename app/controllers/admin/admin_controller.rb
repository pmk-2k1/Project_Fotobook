class AdminController < ApplicationController
  # before_action :authorized?
  private
  # def authorized?
  #   unless current_user.has_role? :admin
  #     flash[:error] = "You are not authorized to view that page."
  #     redirect_to root_path
  #   end
  # end
  def set_
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :admin, :reset_password_token, :avatar,
                                 :current_password, :password_confirmation)
  end

end
