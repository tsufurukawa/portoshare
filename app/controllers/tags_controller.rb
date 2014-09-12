class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @tags.tokens(params[:q].strip.downcase) }
      # params[:q] is the query parameter from tokenInput
    end
  end
end