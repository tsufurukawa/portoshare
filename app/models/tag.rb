class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :projects, through: :taggings
  validates_uniqueness_of :name

  def self.tokens(query)
    filtered_query = query.strip.downcase
    tags = where("name like ?", "%#{filtered_query}%")
    tags << {id: "<<<#{filtered_query}>>>", name: "New: \"#{filtered_query}\""} unless find_by_name(filtered_query)
    tags
  end

  def self.ids_from_tokens(tokens, project)
    unless Tag.item_count(tokens) > 5 || project.errors.present?
      tokens.gsub!(/<<<(.+?)>>>/) { create(name: $1).id }
    else
      tokens.gsub!(/<<<(.*)>>>/, "")
    end
    tokens.split(',').uniq.reject(&:empty?)
  end

  def self.item_count(tokens)
    tokens.split(",").count
  end
end