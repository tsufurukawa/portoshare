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

  describe "#tag_list" do
    let(:tag1) { Fabricate(:tag, name: "tag1") }
    let(:tag2) { Fabricate(:tag, name: "tag2") }
    let(:project) { Fabricate(:project) }

    it "returns a string of tag names delimited by a comma" do
      project = Fabricate(:project)
      project.tags << [tag1, tag2]
      expect(project.tag_list).to eq("tag1, tag2")
    end
  end

  describe "#save_tags" do
    let(:project) { Fabricate(:project) }

    it "returns one tag for a one item string" do
      project.tag_list = "tag1"
      project.save_tags
      expect(project.tags.first.name).to eq("tag1")
    end

    it "returns multiple tags for multiple item string" do
      project.tag_list = "tag1, tag2  ,  tag3"
      project.save_tags
      expect(project.tags.pluck(:name)).to eq(["tag1", "tag2", "tag3"])
    end

    it "does not create duplicate tags" do
      Tag.create(name: "tag3")
      project.tag_list = "tag1, tag2, tag3"
      project.save_tags
      expect(Tag.count).to eq(3)
    end
  end
end