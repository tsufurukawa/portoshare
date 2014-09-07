class ProjectDetailsController < ApplicationController
  before_action :require_authenticated_user, only: [:new, :create]
  before_action :require_project_to_belong_to_current_user, only: [:new, :create]

  def new
    @project_detail = ProjectDetail.new
  end

  def create
    project = Project.find(params[:project_id])
    @project_detail = ProjectDetail.new(set_project_detail_params)
    @project_detail.project = project
    
    if @project_detail.save
      redirect_to user_project_path(current_user, project)
      flash[:success] = "You've successfully created a new project!"
    else
      render :new
    end
  end

  private

  def set_project_detail_params
    params.require(:project_detail).permit(:header, :content)
  end

  def require_project_to_belong_to_current_user
    project = Project.find_by_id(params[:project_id])

    unless project && project.user == current_user
      flash[:danger] = "You don't have access to that page."
      redirect_to current_user
    end
  end
end