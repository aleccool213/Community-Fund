class UsersController < ApplicationController
  before_filter :user_exists
  def show
    @projects = @user.projects.order('updated_at DESC')
    @funds = @user.funds.order('updated_at DESC')
    @communities = @user.communities.active
    feedbacks = Feedback.where("project_id in (?)", @user.projects.pluck(:id))
    if feedbacks.count == 0
      @average_rating = 'No feedback received.'
    else
      sum = 0
      feedbacks.each do |feedback|
        sum += feedback.rating
      end
      @average_rating = (sum.to_f() / feedbacks.count).round(1)
      if @user == current_user
        @feedbacks = feedbacks
      end
    end
  end
  
  def user_exists
    @user = User.find_by_username(params[:username])
    redirect_to root_path if @user.blank?
  end
end