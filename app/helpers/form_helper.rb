module FormHelper
  def setup(project)
    # ensure at least once 'Detailed Info' form is shown at all times
    project.project_details.build if project.project_details.blank?
    return project
  end
end