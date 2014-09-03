class AuthorizationsController < ApplicationController
  before_action :require_authenticated_user, only: [:new, :create, :destroy]
  before_action only: [:new, :destroy] { require_owner(params[:user_id]) }

  def new
    redirect_to "/auth/github"
  end

  def create
    auth = request.env["omniauth.auth"]

    begin  
      authorization = Authorization.create!({
        provider: auth[:provider],
        uid: auth[:uid],
        access_token: auth[:credentials][:token],
        user: current_user
      })
      flash[:success] = "You have successfully linked your Github account!"
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "There was an error when attempting to link your Github account. Please contact customer service if the problem persists."
    end

    redirect_to edit_user_path(current_user)
  end

  def destroy
    if current_user.has_linked_github?
      current_user.github_authorization.destroy
      flash[:success] = "You have unlinked your Github account."
    else
      flash[:danger] = "You have not yet linked your Github account."
    end
    
    redirect_to edit_user_path(current_user)
  end
end