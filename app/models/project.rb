class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_details, dependent: :destroy
  accepts_nested_attributes_for :project_details, allow_destroy: true, limit: 3, reject_if: :all_blank

  validates_presence_of :title, :subtitle, :url, :main_description
  validates_length_of :main_description, maximum: 480, too_long: "%{count} characters is the maximum allowed"
end