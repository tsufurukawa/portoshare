require 'rails_helper'

describe ProjectsController do
  describe "GET index" do
    it "sets the @projects variable ordered reverse chronologically by 'updated_at'" do
      project1 = Fabricate(:project, updated_at: 3.days.ago)
      project2 = Fabricate(:project, updated_at: 2.days.ago)
      get :index
      expect(assigns(:projects)).to eq([project2, project1])
    end

    it "sets the @project variable by returning the first 8 records" do
      10.times { Fabricate(:project) }
      get :index
      expect(assigns(:projects).count).to eq(8)
    end
  end

  describe "GET show" do
    it "sets the @project variable" do
      alice = Fabricate(:user)
      project = Fabricate(:project)
      get :show, id: project.slug
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
      let(:action) { post :create, project: Fabricate.attributes_for(:project) }
    end

    context "with too many nested attributes (more than 5 'project detail' entries)" do
      let(:alice) { Fabricate(:user) }

      before do
        sets_current_user(alice)
        post :create, 
          "project"=>
            {"title"=>"",
            "subtitle"=>"",
            "url"=>"",
            "main_description"=>"",
            "project_details_attributes"=>
              {"0"=>{"header"=>"", "content"=>"", "_destroy"=>"false"},
              "1410214460864"=>{"header"=>"", "content"=>"", "_destroy"=>"false"},
              "1410214462363"=>{"header"=>"", "content"=>"", "_destroy"=>"false"},
              "1410214463930"=>{"header"=>"", "content"=>"", "_destroy"=>"false"},
              "1410214465579"=>{"header"=>"", "content"=>"", "_destroy"=>"false"},
              "1410214467198"=>{"header"=>"", "content"=>"", "_destroy"=>"false"}
            }
          }
      end

      it "sets an error message" do
        expect(flash[:danger]).to eq("Maximum 5 records are allowed. Got 6 records instead.")
      end

      it "sets the @project variable" do
        expect(assigns(:project)).to be_a_new(Project)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end

    context "with successful validations" do
      let(:alice) { Fabricate(:user) }

      before do
        sets_current_user(alice)
        post :create, 
          "project"=>
            {"title"=>"Some Title",
            "subtitle"=>"Some Subtitle",
            "url"=>"http://example.com",
            "main_description"=>"Some description",
            "project_details_attributes"=>
              {"0"=>{"header"=>"Header 1", "content"=>"Content 1", "_destroy"=>"false"},
              "1410214460864"=>{"header"=>"Header 2", "content"=>"Content 2", "_destroy"=>"false"}
            }
          }
      end

      it "sets a success message" do
        expect(flash[:success]).to eq("You have successfully created a new project!!")
      end

      it "creates a new project" do
        expect(Project.count).to eq(1)
      end

      it "associates the project with the user" do
        expect(Project.first.user).to eq(alice)
      end

      it "creates new project detail(s)" do
        expect(ProjectDetail.count).to eq(2)
      end

      it "associates the project detail with the project" do
        expect(Project.first.project_details.count).to eq(2)
      end

      it "redirects to project show path" do
        expect(response).to redirect_to Project.first
      end
    end

    context "with unsuccessful validations" do
      let(:alice) { Fabricate(:user) }

      before do
        sets_current_user(alice)
        post :create, 
          "project"=>
            {"title"=>"Some Title",
            "project_details_attributes"=>
              {"0"=>{"header"=>"Header 1", "content"=>"Content 1", "_destroy"=>"false"}
            }
          }
      end

      it "does not create a project" do
        expect(Project.count).to eq(0)
      end

      it "does not create a project detail object" do
        expect(ProjectDetail.count).to eq(0)
      end

      it "sets an error message" do
        expect(flash[:danger]).to eq("Please fix the following error(s).")
      end

      it "sets the @project variable" do
        expect(assigns(:project)).to be_a_new(Project)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :edit, id: 1 }
    end

    it_behaves_like "require project to belong to current user" do
      let(:action) { get :edit, id: @project.slug }
    end

    it "sets the @project variable" do
      alice = Fabricate(:user)
      sets_current_user(alice)
      project = Fabricate(:project, user: alice)
      get :edit, id: project.slug
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "PATCH update" do
    it_behaves_like "require authenticated user" do
      let(:action) { patch :update, id: 1, project: Fabricate.attributes_for(:project) }
    end

    it_behaves_like "require project to belong to current user" do
      let(:action) { patch :update, id: @project.slug, project: Fabricate.attributes_for(:project) }
    end

    context "with too many nested attributes (more than 5 'project detail' entries)" do
      let(:alice) { Fabricate(:user) }
      let(:project) { Fabricate(:project, user: alice) }

      before do
        sets_current_user(alice)
        patch :update, id: project.slug, project: Fabricate.attributes_for(:project, title: "new title", 
          project_details_attributes: { 
            "0"=>{header: "Header 1", content: "Content 1", _destroy: "false"},
            "1"=>{header: "Header 2", content: "Content 1", _destroy: "false"},
            "2"=>{header: "Header 3", content: "Content 1", _destroy: "false"},
            "3"=>{header: "Header 4", content: "Content 1", _destroy: "false"},
            "4"=>{header: "Header 5", content: "Content 1", _destroy: "false"},
            "5"=>{header: "Header 6", content: "Content 1", _destroy: "false"}
          })
      end

      it "does not update the project attributes" do
        expect(project.reload.title).not_to eq("new title")
        expect(project.reload.project_details).to be_empty
      end

      it "sets a flash error message" do
        expect(flash[:danger]).to eq("Maximum 5 records are allowed. Got 6 records instead.")
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end

      it "sets the @project variable" do
        expect(assigns(:project)).to eq(project)
      end
    end

    context "with successful validations" do
      let(:alice) { Fabricate(:user) }
      let(:project) { Fabricate(:project, user: alice) }

      before do
        sets_current_user(alice)
        patch :update, id: project.slug, project: Fabricate.attributes_for(:project, title: "new title", 
          project_details_attributes: { 
            "0"=>{header: "Header 1", content: "Content 1", _destroy: "false"},
          })
      end

      it "updates the project attributes" do
        expect(project.reload.title).to eq("new title")
        expect(project.reload.project_details).to be_present
      end

      it "redirects to project show path" do
        expect(response).to redirect_to project.reload
      end
    end

    context "with unsuccessful validations" do
      let(:alice) { Fabricate(:user) }
      let(:project) { Fabricate(:project, user: alice) }

      before do
        sets_current_user(alice)
        patch :update, id: project.slug, project: { title: "", subtitle: "new subtitle" }
      end

      it "does not update the project attributes" do
        expect(project.reload.subtitle).not_to eq("new subtitle")
      end

      it "sets an error message" do
        expect(flash[:danger]).to eq("Please fix the following error(s).")
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end
    end
  end
end