class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_unauthenticated_user
    # TODO: change "projects_path"
    if logged_in?
      flash[:danger] = "You cannot access that page."
      redirect_to projects_path
    end
  end

  def require_authenticated_user
    unless logged_in?
      flash[:danger] = "You must be logged in to access that page."
      redirect_to root_path
    end
  end

  def require_owner(user_params_id)
    access_denied unless logged_in? && (user_params_id.to_i == current_user.id)
  end

  def access_denied
    flash[:danger] = "You don't have access to that page."
    redirect_to user_path(current_user)
  end

  def set_back_redirect(&backup_path)
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to backup_path.call
  end
end
