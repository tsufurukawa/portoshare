require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    # TODO: change "projects_path"
    it_behaves_like "require unauthenticated user" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do    
    # TODO: change "projects_path"
    it_behaves_like "require unauthenticated user" do
      let(:action) { post :create }
    end

    context "with valid authentication" do
      let(:alice) { Fabricate(:user) }
      before { post :create, email: alice.email, password: alice.password }

      it "sets the session for the authenticated user" do
        expect(session[:user_id]).to eq(alice.id)
      end

      # TODO: change projects_path
      it "redirects to project index page for html request" do
        expect(response).to redirect_to projects_path
      end
    end

    context "with invalid authentication" do
      let(:alice) { Fabricate(:user) }
      before { post :create, email: alice.email, password: alice.password + "123" }

      it "does not set the session for the user" do
        expect(session[:user_id]).to be_nil
      end

      it "renders the new template for html request" do
        expect(response).to render_template :new
      end
    end

    context "for ajax request" do
      let(:alice) { Fabricate(:user) }

      it "renders the 'create' javascript template for valid authentication" do
        xhr :post, :create, email: alice.email, password: alice.password
        expect(response).to render_template :create
      end

      it "renders the 'login_fail' javascript template for invalid authentication" do
        xhr :post, :create, email: alice.email, password: alice.password + "123"
        expect(response).to render_template :login_fail
      end
    end
  end
end