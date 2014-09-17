require 'rails_helper'

describe VotesController do
  describe "POST create" do
    it_behaves_like "require authenticated user" do
      let(:action) { post :create, id: 1 }
    end

    let(:alice) { Fabricate(:user) }
    let(:project) { Fabricate(:project) }
    
    before do |example|
      unless example.metadata[:skip_before]
        request.env["HTTP_REFERER"] = "http://test.host/"
        sets_current_user(alice)
        post :create, id: project.slug
      end
    end

    it "creates a vote" do
      expect(Vote.count).to eq(1)
    end

    it "creates a vote associated with the project" do
      expect(project.votes.count).to eq(1)
    end

    it "creates a vote associated with the user" do
      expect(Vote.first.user).to eq(alice)
    end

    it "redirects back to previous page for html request" do
      expect(response).to redirect_to :back
    end

    it "renders the 'create' javascript template for ajax request", skip_before: true do
      sets_current_user(alice)
      xhr :post, :create, id: project.slug
      expect(response).to render_template :create
    end
  end
end