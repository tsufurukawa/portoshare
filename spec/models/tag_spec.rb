require 'rails_helper'

describe Tag do
  describe ".ids_from_token" do
    let(:project) { Fabricate(:project) }
    let(:tokens) { "3,5,<<<new tag 1>>>" }

    it "creates new tags when token contains <<< >>>" do
      Tag.ids_from_tokens(tokens, project)
      expect(Tag.last.name).to eq("new tag 1")
      expect(Tag.count).to eq(1)
    end

    it "returns an array of tag ids" do
      expect(Tag.ids_from_tokens(tokens, project)).to eq(["3", "5", "#{Tag.last.id}"])
    end

    it "does not create new tags when there are any validation errors" do
      project = double(:project, errors: "an error")
      expect(Tag.ids_from_tokens(tokens, project)).to eq(["3", "5"])
      expect(Tag.count).to eq(0)
    end
  end

  describe ".item_count" do
    it "returns the number of tag items in the token" do
      tokens = "1, 4, 5, <<<new tag>>>, 3"
      expect(Tag.item_count(tokens)).to eq(5)
    end
  end
end