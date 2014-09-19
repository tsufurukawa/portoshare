class PagesController < ApplicationController
  def front
    @sample_user = User.find_by(username: "tsufurukawa")
    @sample_project = Project.find_by(title: "PortoShare")
  end
end