class UsersController < ApplicationController
  def show
    if @user = User.find_by_username(params[:username])
      @projects = @user.projects.order('updated_at DESC')
      @funds = @user.funds.order('updated_at DESC')
      @communities = @user.communities.active
      @feedbacks = @user.feedbacks.order('updated_at DESC')
    else
      redirect_to root_path
    end
  end
end