class AuthorizationsController < ApplicationController
  before_action :require_authenticated_user, only: [:new, :create, :destroy]
  before_action :set_user, only: [:new, :destroy]
  before_action only: [:new, :destroy] { require_owner(@user.id) }

  def new
    redirect_to "/auth/github"
  end

  def create
    auth = request.env["omniauth.auth"].except(:extra)

    begin
      authorization = Authorization.find_or_create_by!({
        provider: auth[:provider],
        uid: auth[:uid],
        access_token: auth[:credentials][:token],
        nickname: auth[:info][:nickname],
        url: auth[:info][:urls][:GitHub],
        user: current_user
      })
      flash[:success] = "You have successfully linked your Github account!"
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "There was an error when attempting to link your Github account. Please contact customer service if the problem persists."
    end

    set_back_redirect { edit_user_path(current_user) }
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

  # for catching invalid authentication on provider side
  def failure
    flash[:danger] = params[:message] if params[:message]
    redirect_to edit_user_path(current_user)
  end

  def set_user
    @user = User.find_by_slug!(params[:user_id])
  end
end