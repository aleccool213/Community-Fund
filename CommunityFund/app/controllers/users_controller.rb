class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @projects = @user.projects
    @funds = @user.funds
    @communities = @user.communities
    @feedbacks = @user.feedbacks
  end
end