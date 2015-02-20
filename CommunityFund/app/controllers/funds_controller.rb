class FundsController < ApplicationController

  def new
    @new_fund_form = ::NewFundForm.new(user: current_user, project: Project.find(params[:project_id]))
    @project = @new_fund_form.project
    @rewards = @project.rewards

    # load communities for this project
    # if user is in all of them, don't load any
    # if user is in no communities, load all project communities
    # otherwise only load communities that user is not in
  end

  def create

  end
end
