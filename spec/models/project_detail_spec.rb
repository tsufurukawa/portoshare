require 'rails_helper'

describe ProjectDetail do
  it { should belong_to(:project) }
  it { should validate_presence_of(:header) }
  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:content).is_at_most(400).with_message("400 characters is the maximum allowed")}
end