class UsersController < ApplicationController
  before_filter :user_exists
  def show
    @projects = @user.projects.order('updated_at DESC')
    @funds = @user.funds.order('updated_at DESC')
    @communities = @user.communities.active
    if @user == current_user
      @feedbacks = @user.feedbacks.order('updated_at DESC')
    end
  end
  
  def user_exists
    @user = User.find_by_username(params[:username])
    redirect_to root_path if @user.blank?
  end
end