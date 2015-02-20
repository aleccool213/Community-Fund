class FundsController < ApplicationController

  def new
    @new_fund_form = ::NewFundForm.new(user: current_user, project: Project.find(params[:project_id]))
    @project = @new_fund_form.project
    @rewards = @project.rewards

    # load communities for this project
    # if user is in all of them, don't load any
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

  def create
    binding.pry
  end
end
