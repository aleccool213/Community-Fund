class FundsController < ApplicationController

  before_filter :load_project_and_communities, only: [:new, :create, :edit, :update]

  def new
    if current_user.funds.where(project_id: @project.id).present?
      redirect_to edit_fund_path(id: current_user.funds.where(project_id: @project.id))
    end
    @new_fund_form = ::NewFundForm.new(user: current_user, project: @project, communities: @communities)
    @rewards = @project.rewards   
  end

  def create
    @new_fund_form = ::NewFundForm.new(user: current_user, project: @project, communities: @communities)
    @new_fund_form.submit(params)
    redirect_to project_path(id: @project.id, new_fund_id: @new_fund_form.fund.id)
  end

  def edit
    @fund = Fund.find(params[:id])
    @edit_fund_form = ::EditFundForm.new(user: current_user, project: @project, fund: @fund)
    @rewards = @project.rewards
  end

  def update
    @fund = Fund.find(params[:id])
    @edit_fund_form = ::EditFundForm.new(user: current_user, project: @project, fund: @fund)
    @edit_fund_form.submit(params)
    redirect_to project_path(id: @project.id)
  end

  def load_project_and_communities
    @project = Project.find(params[:project_id])
    if current_user.communities == @project.communities
      @communities = []
    # if user is in no communities, load all project communities
    elsif current_user.communities.blank?
      @communities = @project.communities
    # otherwise only load communities that user is not in
    else
      @communities = @project.communities.where("id not in (?)", current_user.communities.pluck(:id))
    end

  end
end
