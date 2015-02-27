class UsersController < ApplicationController
  def show
    if @user = User.find_by_username(params[:username])
      @projects = @user.projects
      @funds = @user.funds
      @communities = @user.communities
      @feedbacks = @user.feedbacks
    else
      redirect_to root_path
    end
  end
end