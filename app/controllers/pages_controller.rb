class PagesController < ApplicationController
  def front
    @sample_user = User.find_by(username: "tsufurukawa")
    @sample_project = Project.where(title: "PortoShare", user: @sample_user).first
  end
end