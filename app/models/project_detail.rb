class ProjectDetail < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :header, :content
  validates_length_of :content, maximum: 400, too_long: "%{count} characters is the maximum allowed"
end