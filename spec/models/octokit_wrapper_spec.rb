require 'rails_helper'

describe OctokitWrapper do
  describe OctokitWrapper::Client, :vcr do
    context "with valid access token (or authorized github access)" do
      let(:valid_test_token) { ENV["OCTOKIT_TEST_GITHUB_TOKEN"] }

      it "creates a new client successfully" do
        client = OctokitWrapper::Client.new(access_token: valid_test_token)
        expect(client.response.access_token).to eq(valid_test_token)
      end

      it "contains public repositories stored in an array" do
        client = OctokitWrapper::Client.new(access_token: valid_test_token)
        expect(client.repos).to be_an(Array)
      end
    end

    context "with invalid access token (or unauthorized github access)" do
      it "sets an error message when accessing client data" do
        client = OctokitWrapper::Client.new(access_token: "invalid token")
        expect(client.repos).to eq("There was an error trying to access the Github account.")
        expect(client.valid?).to be_falsy
      end
    end
  end
end