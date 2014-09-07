require 'rails_helper'

describe ProjectDetailsController do
  describe "GET new" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :new, project_id: 1 }
    end

    it_behaves_like "require project to belong to current user" do
      let(:action) { get :new, project_id: @project.id}
    end

    it "sets a @project_detail variable" do
      alice = Fabricate(:user)
      sets_current_user(alice)
      project = Fabricate(:project, user: alice)
      get :new, project_id: project.id
      expect(assigns(:project_detail)).to be_a_new(ProjectDetail)
    end
  end

  describe "POST create" do
    it_behaves_like "require authenticated user" do
      let(:action) { post :create, project_id: 1 }
    end

    it_behaves_like "require project to belong to current user" do
      let(:action) { post :create, project_id: @project.id, project_detail: {} }
    end

    context "for valid input" do
      let(:alice) { Fabricate(:user) }
      let(:project) { Fabricate(:project, user: alice) }

      before do
        sets_current_user(alice)
        post :create, project_id: project.id, project_detail: Fabricate.attributes_for(:project_detail)
      end

      it "creates a new project detail object" do
        expect(ProjectDetail.count).to eq(1)
      end

      it "associates the project detail with the project" do
        expect(ProjectDetail.first.project).to eq(project)
      end

      it "redirects to project show page" do
        expect(response).to redirect_to user_project_path(alice, project)
      end

      it "sets a flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "for invalid iput" do
      let(:alice) { Fabricate(:user) }
      let(:project) { Fabricate(:project, user: alice) }

      before do
        sets_current_user(alice)
        post :create, project_id: project.id, project_detail: { header: "Some header" }
      end

      it "does not create a new project detail object" do
        expect(ProjectDetail.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end
end