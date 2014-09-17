class PasswordResetsController < ApplicationController
  before_action :require_authenticated_user
  before_action :set_user
  before_action { require_owner(@user.id) }

  def new; end

  def create
    @user.updating_password = true

    if @user && @user.authenticate(params[:old_password])
      if params[:new_password] == params[:new_password_confirmation] && @user.update(password: params[:new_password])
        flash[:success] = "You have successfully reset your password."
        redirect_to @user
      elsif params[:new_password] == params[:new_password_confirmation]
        flash.now[:danger] = "Password must be at least 6 characters long. Please try again."
        render :new        
      else
        flash.now[:danger] = "The new passwords did not match. Please try again."
        render :new        
      end
    else
      flash.now[:danger] = "The password you entered is incorrect. Please try again."
      render :new
    end
  end

  private

  def set_user
    @user = User.find_by_slug!(params[:user_id])
  end
end