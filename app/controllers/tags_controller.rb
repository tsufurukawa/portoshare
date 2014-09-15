class TagsController < ApplicationController
  helper_method :sort_column
  before_action :require_authenticated_user, only: [:index]

  def index
    @tags = Tag.order(:name)
    respond_to do |format|
      format.json { render json: @tags.tokens(params[:q]) }
      # params[:q] is the query parameter from tokenInput
    end
  end

  def show
    @projects = Project.tagged_with(params[:tag]).order(sort_column).page(params[:page])
    @tag_name = params[:tag]
    @show_tag = true
    render 'projects/index'
  end

  private

  def sort_column
    params[:sort] = 
      if ["title", "subtitle", "updated_at desc", "votes_count desc"].include?(params[:sort])
        params[:sort]
      else
        "updated_at desc"
      end
  end
end
