class UsersController < ApplicationController
  before_action :require_authenticated_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_unauthenticated_user, only: [:new, :create]
  before_action :require_owner, only: [:edit, :update]

  def show; end

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

  def edit; end

  def update
    if params[:remove_avatar].present?
      @user.update_columns(avatar: nil)
      flash[:success] = "You have deleted your profile picture."
      redirect_to edit_user_path(@user)
      return
    end

    if @user.update(user_params)
      flash[:success] = "You have successfully updated your profile."
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :username, :location, :bio, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_owner
    unless logged_in? && (@user.id == current_user.id)
      flash[:danger] = "You don't have access to that page."
      redirect_to user_path(current_user)
    end
  end
end