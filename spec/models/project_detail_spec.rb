require 'rails_helper'

describe ProjectDetail do
  it { should belong_to(:project) }
  it { should validate_presence_of(:header) }
  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:content).is_at_most(800).with_message("800 characters is the maximum allowed")}
end