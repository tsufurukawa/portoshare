require 'rails_helper'

describe ProjectsController do
  describe "GET index" do
    it "sets the @projects variable" do
      project1 = Fabricate(:project)
      project2 = Fabricate(:project)
      get :index
      expect(assigns(:projects)).to eq([project1, project2])
    end
  end
end