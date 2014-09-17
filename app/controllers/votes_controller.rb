class VotesController < ApplicationController
  before_action :require_authenticated_user

  def create
    @project = Project.find_by_slug!(params[:id])
    @vote = Vote.create(project: @project, user: current_user)

    respond_to do |format|
      format.html { set_back_redirect { project_path(@project) } }
      format.js
    end
  end
end