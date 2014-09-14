require 'rails_helper'

describe TagsController do
  describe "GET index" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :index, q: "query string"}
    end
  end

  describe "GET show" do
    let(:tag) { Fabricate(:tag) }

    it "returns projects with the specified tag and sets it to the @project variable" do
      project1 = Fabricate(:project, updated_at: 3.days.ago)
      project2 = Fabricate(:project)
      project3 = Fabricate(:project, updated_at: 1.days.ago)
      project1.tags << tag
      project3.tags << tag
      get :show, tag: tag.name
      expect(assigns(:projects)).to eq([project3, project1])
    end

    it "returns the first 8 records" do
      10.times { Fabricate(:project) }
      Project.all.each { |project| project.tags << tag }
      get :show, tag: tag.name
      expect(assigns(:projects).count).to eq(8)
    end

    it "renders the projects index page" do
      get :show, tag: tag.name
      expect(response).to render_template "projects/index"
    end

    it "sets the @tag_name variable" do
      get :show, tag: tag.name
      expect(assigns(:show_tag)).to eq(true)
    end
  end
end