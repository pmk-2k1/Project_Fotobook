class ApplicationController < ActionController::Base
  # def default_url_options
  #   { locale: I18n.locale }
  # end
  before_action :set_locale
  before_action :authenticate_user!

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # DEVISE
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user|
      user.permit(:email, :password)
    end

    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:first_name, :last_name, :email, :password)
    end

    # devise_parameter_sanitizer.permit(:account_update) do |user|
    #   user.permit(:first_name, :last_name, :email, :password, :cur
    # end
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    feed_path(current_user)
  end

end
