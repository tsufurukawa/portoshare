class Project < ActiveRecord::Base
  attr_accessor :tag_list

  belongs_to :user
  has_many :project_details, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :project_details, allow_destroy: true, limit: 5, reject_if: :all_blank

  validates_presence_of :title, :subtitle, :url, :main_description
  validates_length_of :main_description, maximum: 800, too_long: "%{count} characters is the maximum allowed"
  validate :validate_tag_list
  validates_format_of :url, 
    with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\Z/ix, 
    message: "invalid url format"
  
  mount_uploader :image, ImageUploader

  before_save :save_tags

  def validate_tag_list
    errors.add(:tag_list, "too many tags (5 is the maximum allowed)") if tag_list && Tag.item_count(tag_list) > 5
  end

  # tag_list => ex: "1, 3, 10, <<<new-tag>>>"
  def tag_list_items
    tag_list.present? ? Tag.find(Tag.ids_from_tokens(tag_list, self)) : tags
  end

  def save_tags
    self.tag_ids = Tag.ids_from_tokens(tag_list, self) if tag_list.present?
  end
end