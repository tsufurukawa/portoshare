class TagsController < ApplicationController
  before_action :require_authenticated_user, only: [:index]

  def index
    @tags = Tag.order(:name)
    respond_to do |format|
      format.json { render json: @tags.tokens(params[:q]) }
      # params[:q] is the query parameter from tokenInput
    end
  end

  def show
    @projects = Project.tagged_with(params[:tag]).page(params[:page])
    @tag_name = params[:tag]
    @show_tag = true
    render 'projects/index'
  end
end