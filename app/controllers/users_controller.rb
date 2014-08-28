class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      redirect_to projects_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end