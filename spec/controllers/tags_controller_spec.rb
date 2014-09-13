require 'rails_helper'

describe TagsController do
  describe "GET index" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :index, q: "query string"}
    end
  end

  describe "GET show" do
    it "returns projects with the specified tag and sets it to the @project variable" do
      project1 = Fabricate(:project)
      project2 = Fabricate(:project)
      project3 = Fabricate(:project)
      tag = Fabricate(:tag)
      project1.tags << tag
      project3.tags << tag
      get :show, tag: tag.name
      expect(assigns(:projects)).to eq([project1, project3])
    end

    it "returns the first 20 records" do
      21.times { Fabricate(:project) }
      tag = Fabricate(:tag)
      Project.all.each { |project| project.tags << tag }
      get :show, tag: tag.name
      expect(assigns(:projects).count).to eq(20)
    end

    it "render the projects index page" do
      tag = Fabricate(:tag)
      get :show, tag: tag.name
      expect(response).to render_template "projects/index"
    end
  end
end