require 'rails_helper'

describe User do
  it { should have_secure_password }
  it { should ensure_length_of(:password).is_at_least(5) }
  it { should have_many(:projects).order(created_at: :desc) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
end