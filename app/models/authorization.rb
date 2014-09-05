class Authorization < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :provider, :uid, :access_token
  validates_uniqueness_of :user_id, scope: :provider
  
end