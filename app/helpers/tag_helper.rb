module TagHelper
  def display_tags(project)
    raw(project.tags.map(&:name).map { |tag_name| link_to tag_name, "#" }.join(', '))
  end
end