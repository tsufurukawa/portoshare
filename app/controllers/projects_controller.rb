class ProjectsController < ApplicationController
  before_action :require_authenticated_user, only: [:new, :create]
  before_action :set_user, only: [:new, :create]
  before_action only: [:new, :create] { require_owner(@user.id) }

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = @user

    if @project.save
      flash[:success] = "You have successfully created a new project."
      redirect_to user_project_path(@user, @project)
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def project_params
    params.require(:project).permit(:title, :subtitle, :url, :main_description)
  end
end