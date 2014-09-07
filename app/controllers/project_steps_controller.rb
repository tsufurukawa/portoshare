class ProjectStepsController < ApplicationController
  include Wicked::Wizard
  steps :detailed_info

  def new
    # pseudocode
    # first change route for project creation => don't want it namespaced under '/user'
    # so don't need 'require_owner' tess for the :new and :create actions
    # this 'new project' form will be posted to projects#create as usual and if validations passes
    # it will redirect to project_steps_path -> which maps to "project_steps#index" which by default
    # redirects to the first step (i.e. 'detailed_info')
    # in the 'detailed_info' view, we have a form with fields ('header', and 'content') from a different
    # model (perhaps something like ProjectDetail)
    # so inside 'detailed_info' we'll have a 'form_for' for @project_detail (which we have to set inside
    # the 'show' action)
    # this form will submit to the "#update" action

    @project = Project.new()
    render_wizard(steps.first) 
  end

  def show
    render_wizard
  end
end
