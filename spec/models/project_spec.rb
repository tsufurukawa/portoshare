require 'rails_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:project_details).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:subtitle) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:main_description) }
  it { should ensure_length_of(:main_description).is_at_most(800).with_message("800 characters is the maximum allowed")}
  it { should accept_nested_attributes_for(:project_details).allow_destroy(true).limit(5) }
end