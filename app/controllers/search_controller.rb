class SearchController < ApplicationController
  def index
    if params[:sort].present?
      sort_by = { params[:sort] => :asc }
    else
      sort_by = { updated_at: :desc }
    end

    @projects = Project.text_search(params[:query]).order(sort_by).page(params[:page])
    @no_match_msg = @projects.blank?
    render 'projects/index'
  end

  def sort
    sort_by = params[:sort]
    @projects = Project.order(sort_by => :asc).page(params[:page])
    render 'projects/index' 
  end
end