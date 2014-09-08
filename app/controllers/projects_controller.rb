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
    begin
      @project = Project.new(project_params)
      @project.user = current_user

      if @project.save
        flash[:success] = "You have successfully created a new project!!"
        redirect_to user_project_path(current_user, @project)
      else
        flash[:danger] = "Please fix the following error(s)."
        render :new
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords => e
      @project = Project.new(project_params_without_details)
      flash.now[:danger] = e.message
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :subtitle, :url, :main_description, 
      project_details_attributes: [:id, :header, :content, :_destroy])
  end

  def project_params_without_details
    params.require(:project).permit(:title, :subtitle, :url, :main_description)
  end
end