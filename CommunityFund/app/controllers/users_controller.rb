class UsersController < ApplicationController
  before_filter :user_exists
  def show
    @projects = @user.projects.order('updated_at DESC')
    @funds = @user.funds.order('updated_at DESC')
    @communities = @user.communities.active
    feedbacks = Feedback.where("project_id in (?)", @user.projects.pluck(:id))
    if feedbacks.present?
      sum = 0
      total = 0
      feedbacks.each do |feedback|
        sum += feedback.rating
        total += 1
      end
      @average_rating = (sum.to_f() / total).round(1)
      if @user == current_user
        @feedbacks = feedbacks
      end
    else
      @average_rating = 'No feedback received.'
    end
  end
  
  def user_exists
    @user = User.find_by_username(params[:username])
    redirect_to root_path if @user.blank?
  end
end