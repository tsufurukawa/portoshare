class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_details, dependent: :destroy
  accepts_nested_attributes_for :project_details, allow_destroy: true, limit: 5, reject_if: :all_blank

  validates_presence_of :title, :subtitle, :url, :main_description
  validates_length_of :main_description, maximum: 800, too_long: "%{count} characters is the maximum allowed"
  validates_format_of :url, with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\Z/ix, message: "invalid url format"
  mount_uploader :image, ImageUploader
end