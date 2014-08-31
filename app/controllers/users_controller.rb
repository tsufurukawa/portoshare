class UsersController < ApplicationController
  before_action :require_unauthenticated_user, only: [:new, :create]

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|  
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "You have successfully registered for an account. Welcome to Portoshare!!!"
        format.html { redirect_to projects_path }
        format.js
      else
        format.html { render :new }
        format.js { render :signup_fail }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end