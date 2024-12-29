class RegistrationsController < ApplicationController
  include Authentication
  allow_unauthenticated_access
  layout "forms"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params())
    if @user.save
      start_new_session_for(@user)
      redirect_to "/", notice: "Successfully signed up!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:email_address, :password, :password_confirmation)
  end
end
