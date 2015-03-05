class UsersController < ApplicationController
  before_filter :redirect_to_root, :unless => :user_exists?
  def show
    @user = User.find_by_username(params[:username])
    @projects = @user.projects.order('updated_at DESC')
    @funds = @user.funds.order('updated_at DESC')
    @communities = @user.communities.active
    @feedbacks = @user.feedbacks.order('updated_at DESC')
  end
  
  def user_exists?
    User.find_by_username(params[:username]).present?
  end
  
  def redirect_to_root
    redirect_to root_path
  end
end