require 'rails_helper'

describe UsersController do
  describe "GET new" do
    #TODO: change projects_path
    it_behaves_like "require unauthenticated user" do
      let(:action) { get :new }
    end
  end

  describe "GET show" do
    context "when user has a linked github account with authorized github access" do
      let(:alice) { Fabricate(:user) }
      let!(:authorization) { Fabricate(:authorization, provider: "github", user: alice) }

      before do
        client = double(:client, repos: [1, 2, 3], valid?: true)
        allow(OctokitWrapper::Client).to receive(:new).and_return(client)
        get :show, id: alice.id
      end

      it "sets the @user variable" do
        expect(assigns(:user)).to eq(alice)
      end

      it "sets the @repositories variable" do
        expect(assigns(:repositories)).to eq([1, 2, 3])
      end

      it "sets the @user_github variable" do
        expect(assigns[:user_github]).to eq(authorization)
      end
    end

    context "when user has a linked github account with unauthorized github access" do
      let(:alice) { Fabricate(:user) }

      before do
        authorization = Fabricate(:authorization, provider: "github", user: alice)
        client = double(:client, repos: "Error message", valid?: false)
        allow(OctokitWrapper::Client).to receive(:new).and_return(client)
        get :show, id: alice.id
      end

      it "unlinks the user's github account" do
        expect(alice.reload.authorizations).not_to be_present
      end
    end

    context "when user does not have a linked github account" do
      let(:alice) { Fabricate(:user) }
      before { get :show, id: alice.id }

      it "sets the @user variable" do
        expect(assigns(:user)).to eq(alice)
      end

      it "does not access the user's github account data" do
        client = double(:client)
        expect(client).not_to receive(:repos)
      end
    end
  end

  describe "POST create" do
    #TODO: change projects_path
    it_behaves_like "require unauthenticated user" do
      let(:action) { post :create }
    end
    
    context "for valid user input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a new user" do        
        expect(User.count).to eq(1)
      end

      it "sets the session for the user" do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it "redirects to projects path for an html request" do
        expect(response).to redirect_to projects_path
      end
    end

    context "for invalid user input" do
      before { post :create, user: { name: "alice" } }

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "renders the new template for an html request" do
        expect(response).to render_template :new
      end
    end

    context "for ajax request" do
      it "renders the 'create' javascript template for valid user input" do
        xhr :post, :create, user: Fabricate.attributes_for(:user)
        expect(response).to render_template :create
      end

      it "renders the 'signup_fail' javascript template for invalid user input" do
        xhr :post, :create, user: { name: "alice" }
        expect(response).to render_template :signup_fail
      end
    end
  end

  describe "GET edit" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :edit, id: 1 }
    end

    it_behaves_like "require owner" do
      let(:action) { get :edit, id: @bob.id }
    end
    
    it "sets the @user variable" do
      alice = Fabricate(:user)
      sets_current_user(alice)
      get :edit, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe "PATCH update" do
    it_behaves_like "require authenticated user" do
      let(:action) { patch :update, id: 1, user: Fabricate.attributes_for(:user) }
    end

    it_behaves_like "require owner" do
      let(:action) { patch :update, id: @bob.id, user: Fabricate.attributes_for(:user) }
    end

    context "for valid user input" do
      let(:alice) { Fabricate(:user) }

      before do
        sets_current_user(alice)
        patch :update, id: alice.id, user: Fabricate.attributes_for(:user, email: "new@email.com", bio: "new bio")
      end

      it "updates the user attributes" do        
        expect(alice.reload.email).to eq("new@email.com")
        expect(alice.reload.bio).to eq("new bio")
      end

      it "redirects to user edit path" do
        expect(response).to redirect_to edit_user_path(alice)
      end

      it "sets a flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "for invalid user input" do
      let(:alice) { Fabricate(:user, username: "alice") }

      before do
        sets_current_user(alice)
        patch :update, id: alice.id, user: { email: nil, username: alice.username + "123" }
      end

      it "does not update the user attributes" do
        expect(alice.reload.username).not_to eq("alice123")
        expect(alice.reload.username).to eq("alice")
      end

      it "renders the edit page" do
        expect(response).to render_template :edit
      end

      it "sets the @user variable" do
        expect(assigns(:user)).to eq(alice)
      end
    end

    context "when 'remove_avatar' parameter is present" do
      let(:alice) { Fabricate(:user, avatar: "default_image") }

      before do
        sets_current_user(alice)
        patch :update, id: alice.id, remove_avatar: true
      end

      it "deletes the user's avatar" do
        expect(alice.reload.avatar.identifier).to be_nil
      end

      it "redirects to user edit page" do
        expect(response).to redirect_to edit_user_path(alice)
      end
    end
  end
end