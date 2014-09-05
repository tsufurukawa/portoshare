class User < ActiveRecord::Base
  has_many :projects, -> { order(created_at: :desc) }
  has_many :authorizations
  has_secure_password validations: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :bio, length: { maximum: 160,
    too_long: "%{count} characters is the maximum allowed" }

  mount_uploader :avatar, AvatarUploader

  def can_edit?(a_user)
    self == a_user
  end

  def github_authorization
    authorizations.where(provider: "github").first
  end

  def has_linked_github?
    github_authorization.present?
  end

  def github_url_present?
    github_authorization.url.present?
  end
end