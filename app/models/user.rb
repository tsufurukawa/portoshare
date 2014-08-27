class User < ActiveRecord::Base
  has_many :projects
  
  has_secure_password validations: false
end