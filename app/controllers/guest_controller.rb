class GuestController < ApplicationController

  skip_before_action :authenticate_user!, only: [:guest_albums, :guest_photos]

  def guest_photos
    @users = User.all
  end

  def guest_albums
    @users = User.all
  end
end
