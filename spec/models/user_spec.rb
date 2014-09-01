require 'rails_helper'

describe User do
  it { should have_secure_password }
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should have_many(:projects).order(created_at: :desc) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should ensure_length_of(:username).is_at_most(20) }
  it { should ensure_length_of(:bio).is_at_most(160).with_message("160 characters is the maximum allowed") }
end