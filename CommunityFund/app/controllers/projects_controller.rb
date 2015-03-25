class ProjectsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_filter :ensure_initiator, only: [:edit, :update]
  before_filter :ensure_open, only: [:edit, :update]

  def new
    country_data = GeoInfo::countries.map { |c| [c.country, c.id] }
    @countries = Hash[*country_data.flatten]
    @communities = Community.active
    @new_project_form = ::NewProjectForm.new(user: current_user, communities: @communities)
    @project = @new_project_form.project
  end

  def create
    @communities = Community.active
    @new_project_form = ::NewProjectForm.new(user: current_user, communities: @communities)
    @new_project_form.submit(params)
    @project = @new_project_form.project
    Milestone.create(:project_id => @project.id, :percentage => 0.0, :fund_id => nil, :description => 'Project has been initiated!')
    redirect_to project_path(id: @project.id)
  end

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
    @rewards = @project.rewards.order('reward_level ASC')
    @fund = current_user.try(:fund_for_project, @project)

    @posts = @project.posts.paginate(page: params[:page], per_page: 15).order("updated_at DESC")
    if params.has_key?(:new_fund_id)
      @new_fund = true
    end
  end

  def edit
    @communities = Community.active
    @edit_project_form = ::EditProjectForm.new(user: current_user, communities: @communities, project: @project)
  end

  def update
    @communities = Community.active
    @edit_project_form = ::EditProjectForm.new(user: current_user, communities: @communities, project: @project)
    @edit_project_form.submit(params)
    redirect_to project_path(id: @project.id)
  end

  private
    def ensure_open
      @project ||= Project.find(params[:id])
      if @project.closed?
        redirect_to project_path(id: @project.id)
      end
    end

    def ensure_initiator
      @project = Project.find(params[:id])
      initiator_or_admin = (current_user.id == @project.initiator.id) || current_user.admin?
      if (not initiator_or_admin) || @project.closed?
        # TODO get this working
        flash[:error] = "Permission Denied"
        redirect_to project_path(id: @project.id)
      end
    end
end
