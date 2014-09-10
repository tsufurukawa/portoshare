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
        display_error_and_render("Please fix the following error(s).")
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords => e
      @project = Project.new(project_params_without_details)
      display_error_and_render(e.message)
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :subtitle, :url, :main_description, :image,
        project_details_attributes: [:id, :header, :content, :_destroy])
  end

  def project_params_without_details
    params.require(:project).permit(:title, :subtitle, :url, :main_description)
  end

  def display_error_and_render(error_msg)
    flash.now[:danger] = error_msg
    render :new
  end
end