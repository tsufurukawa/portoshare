class ProjectsController < ApplicationController
  before_action :require_authenticated_user, only: [:new, :create, :edit, :update]
  before_action :set_project, only: [:show, :edit, :update]
  before_action :require_project_owner, only: [:edit, :update]

  def index
    @projects = Project.all
  end

  def show; end

  def new
    @project = Project.new
  end

  def create
    begin
      @project = Project.new(project_params)
      @project.user = current_user

      if @project.save && @project.errors.empty?
        flash[:success] = "You have successfully created a new project!!"
        redirect_to @project
      else
        error_message = tag_validation_error(@project) || "Please fix the following error(s)."
        display_error_and_render(error_message, :new)
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords => e
      @project = Project.new(project_params_without_details)
      display_error_and_render(e.message, :new)
    end
  end

  def edit; end

  def update
    begin
      if @project.update(project_params) && @project.errors.empty?
        flash[:success] = "You have successfully updated your project!!"
        redirect_to @project
      else
        error_message = tag_validation_error(@project) || "Please fix the following error(s)."
        display_error_and_render(error_message, :edit)
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords => e
      display_error_and_render(e.message, :edit)
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :subtitle, :url, :main_description, :image, :image_cache, :tag_list, :tag_ids,
      project_details_attributes: [:id, :header, :content, :_destroy])
  end

  def project_params_without_details
    params.require(:project).permit(:title, :subtitle, :url, :main_description, :image, :image_cache, :tag_list, :tag_ids)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def display_error_and_render(error_msg, template)
    flash.now[:danger] = error_msg
    render template
  end

  def require_project_owner
    access_denied unless @project.user == current_user
  end

  def tag_validation_error(project)
    "Validation error. Please do not make duplicate tags." if project.errors.messages[:tags].present?
  end
end