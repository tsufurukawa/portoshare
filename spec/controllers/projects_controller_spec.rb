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

  describe "GET show" do
    it "sets the @project variable" do
      alice = Fabricate(:user)
      project = Fabricate(:project)
      get :show, user_id: alice.id, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "GET new" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :new, user_id: 1 }
    end

    it "sets the @project variable" do
      alice = Fabricate(:user)
      sets_current_user(alice)
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "POST create" do
    it_behaves_like "require authenticated user" do
      let(:action) { post :create, user_id: 1, project: Fabricate.attributes_for(:project) }
    end

    context "with valid input" do
      let(:alice) { Fabricate(:user) }
      
      before do
        sets_current_user(alice)
        post :create, project: Fabricate.attributes_for(:project)
      end

      it "creates a new project" do
        expect(Project.count).to eq(1)
      end

      it "associates the project to the user" do
        expect(Project.first.user).to eq(alice)
      end

      it "redirects to the project show path" do
        expect(response).to redirect_to user_project_path(alice, Project.first)
      end
    end

    context "with invalid input" do
      let(:alice) { Fabricate(:user) }

      before do
        sets_current_user(alice)
        post :create, project: { title: "project title" }
      end

      it "does not create a new project" do
        expect(Project.count).to eq(0)
      end 

      it "renders the new project template" do
        expect(response).to render_template :new
      end
    end
  end
end