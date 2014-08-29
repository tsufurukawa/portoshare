require 'rails_helper'

describe UsersController do
  describe "POST create" do
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
      it "renders the 'create' javascript template" do
        xhr :post, :create, user: Fabricate.attributes_for(:user)
        expect(response).to render_template :create
      end
    end
  end
end