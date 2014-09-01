class User < ActiveRecord::Base
  has_many :projects, -> { order(created_at: :desc) }
  has_secure_password validations: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :bio, length: { maximum: 160,
    too_long: "%{count} characters is the maximum allowed" }

  def can_edit?(a_user)
    self == a_user
  end
end