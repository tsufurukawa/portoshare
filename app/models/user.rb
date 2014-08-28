class User < ActiveRecord::Base
  has_many :projects, -> { order(created_at: :desc) }
  has_secure_password validations: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }
end