require 'rails_helper'

describe UsersController do
  describe "POST create" do
    context "for valid user input" do
      it "redirects to project index page" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to projects_path
      end

      it "creates a new user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end
    end

    # context "for invalid user input" do
    #   it "does not create a new user" do
    #     post :create, user: { name: "alice" }
    #     expect(User.count).to eq(0)
    #   end
    # end
  end
end