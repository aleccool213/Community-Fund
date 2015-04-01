class UsersController < ApplicationController
  before_filter :user_exists
  def show
    @projects = @user.projects.order('updated_at DESC')
    @funds = @user.funds.order('updated_at DESC')
    @communities = @user.communities.active
    # find average feedback for this user
    @average_rating = @user.average_rating
    if @user == current_user
      @feedbacks = Feedback.where("project_id in (?)", current_user.projects.pluck(:id))
    else
      @feedbacks = Feedback.where("project_id in (?)", @user.projects.pluck(:id))
    end
  end
  
  def user_exists
    @user = User.find_by_username(params[:username])
    redirect_to root_path if @user.blank?
  end
end