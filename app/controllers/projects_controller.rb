class ProjectsController < ApplicationController
  before_action :require_authenticated_user, only: [:new, :create]

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
    @project.user = current_user

    if @project.save
      redirect_to project_details_new_path(@project)
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :subtitle, :url, :main_description)
  end
end