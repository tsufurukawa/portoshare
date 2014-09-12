require 'rails_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:project_details).dependent(:destroy) }
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:subtitle) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:main_description) }
  it { should ensure_length_of(:main_description).is_at_most(800).with_message("800 characters is the maximum allowed")}
  it { should accept_nested_attributes_for(:project_details).allow_destroy(true).limit(5) }

  describe "#save_tags" do
    let(:project) { Fabricate(:project) }
    let!(:tag1) { Fabricate(:tag, id: 1, name: "tag1") }
    let!(:tag2) { Fabricate(:tag, id: 2, name: "tag2") }
    let!(:tag3) { Fabricate(:tag, id: 3, name: "tag3") }

    it "sets the tags for the project" do
      project.tag_list = "1, 2  , 3"
      project.save_tags
      expect(project.tags.pluck(:name)).to eq(["tag1", "tag2", "tag3"])
    end
  end
end