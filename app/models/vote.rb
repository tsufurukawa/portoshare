class Vote < ActiveRecord::Base
  belongs_to :project, counter_cache: true
  belongs_to :user

  validates_uniqueness_of :project_id, scope: :user_id
end