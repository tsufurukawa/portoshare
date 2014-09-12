require 'rails_helper'

describe ".ids_from_token" do
  let(:project) { Fabricate(:project) }

  it "creates new tags when token contains <<< >>>" do
    tokens = "1,2,<<<new tag 1>>>,<<<new tag 2>>>"
    Tag.ids_from_tokens(tokens, project)
    expect(Tag.last.name).to eq("new tag 2")
    expect(Tag.count).to eq(2)
  end

  it "returns an array of tag ids" do
    tokens = "1,2,<<<new tag 3>>>"
    expect(Tag.ids_from_tokens(tokens, project)).to eq(["1", "2", "#{Tag.last.id}"])
  end
end