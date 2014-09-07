class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :subtitle, :url, :main_description
  validates_length_of :main_description, maximum: 480, too_long: "%{count} characters is the maximum allowed"
end