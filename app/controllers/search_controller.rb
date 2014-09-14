class SearchController < ApplicationController
  def index
    @projects = Project.text_search(params[:query]).order(updated_at: :desc).page(params[:page])
    @no_match_msg = @projects.blank?
    render 'projects/index'
  end
end