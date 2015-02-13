class ProjectsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @communities = Community.active
    @new_project_form = ::NewProjectForm.new(user: current_user, communities: @communities)
    @project = @new_project_form.project
  end


  def create
    @communities = Community.active
    @new_project_form = ::NewProjectForm.new(user: current_user, communities: @communities)
    @new_project_form.submit(params)
    @project = @new_project_form.project
    redirect_to project_path(id: @project.id)
  end

  def show
    @project = Project.find(params[:id])
  end
end
