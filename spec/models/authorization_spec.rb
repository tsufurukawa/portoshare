require 'rails_helper'

describe Authorization do
  it { should belong_to(:user) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:access_token) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:provider) }
end