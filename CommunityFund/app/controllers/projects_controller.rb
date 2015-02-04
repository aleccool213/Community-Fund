class ProjectsController < ApplicationController

  def new
    @communities = Community.active
    @new_project_form = ::NewProjectForm.new(user: current_user, communities: @communities)
  end

  def create
    @communities = Community.active
    @new_project_form = ::NewProjectForm.new(user: current_user, communities: @communities)
    @new_project_form.submit(params[:new_project_form])
  end
end
