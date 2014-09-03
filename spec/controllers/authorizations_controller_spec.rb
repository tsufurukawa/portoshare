require 'rails_helper'

describe AuthorizationsController do
  describe "GET new" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :new, user_id: 1 }
    end

    it_behaves_like "require owner" do
      let(:action) { get :new, user_id: @bob.id }
    end

    it "redirects to the github authorization url" do
      alice = Fabricate(:user)
      sets_current_user(alice)
      get :new, user_id: alice.id
      expect(response).to redirect_to "/auth/github"
    end
  end

  describe "GET create" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :create, provider: "github"}
    end

    let(:alice) { Fabricate(:user) }

    before do 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      sets_current_user(alice)
      get :create, provider: "github"
    end

    it "creates a new github authorization" do
      expect(Authorization.first.provider).to eq("github")
    end

    it "creates a new github authorization associated with the user" do
      expect(Authorization.first.user).to eq(alice)
    end

    it "redirects to user edit path" do
      expect(response).to redirect_to edit_user_path(alice)
    end

    it "sets a flash success message" do
      expect(flash[:success]).to be_present
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "require authenticated user" do
      let(:action) { delete :destroy, user_id: 1, id: 1 }
    end

    it_behaves_like "require owner" do
      let(:action) { delete :destroy, user_id: @bob.id, id: 1 }
    end

    context "when user has a linked github account" do
      let(:alice) { Fabricate(:user) }
      let(:github_auth) { Fabricate(:authorization, user: alice, provider: "github")}
      
      before do
        sets_current_user(alice)
        delete :destroy, user_id: alice.id, id: github_auth.id
      end

      it "unlinks the account" do
        expect(alice.authorizations.reload.count).to eq(0)  
      end

      it "sets a flash success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to edit user path" do
        expect(response).to redirect_to edit_user_path(alice)
      end
    end

    context "when user does not have a linked github account" do
      let(:alice) { Fabricate(:user) }

      before do
        sets_current_user(alice)
        delete :destroy, user_id: alice.id, id: 1
      end

      it "sets a flash error message" do
        expect(flash[:danger]).to be_present
      end

      it "redirects to edit user path" do
        expect(response).to redirect_to edit_user_path(alice)
      end
    end
  end
end