class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    respond_to do |format|  
      if @user.valid?
        session[:user_id] = @user.id
        flash[:success] = "You have successfully registered for an account. Welcome to Portoshare!!!"
        format.html { redirect_to projects_path }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end