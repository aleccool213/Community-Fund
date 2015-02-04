class ProjectsController < ApplicationController

  def new
    @new_project_form = ::NewProjectForm.new(user: current_user)
  end

  def create
    @new_project_form = ::NewProjectForm.new(user: current_user)
    @new_project_form.submit(params[:new_project_form])
  end
end
