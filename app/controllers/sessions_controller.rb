class SessionsController < ApplicationController
  before_action :require_unauthenticated_user, except: [:destroy]
  before_action :require_authenticated_user, only: [:destroy]

  def new; end

  def create
    user = User.find_by_email(params[:email])

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to projects_path }
        format.js
      else
        format.html do
          flash.now[:danger] = "Invalid email or password. Please try again."  
          render :new
        end
        format.js { render :login_fail }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end