class FeedbacksController < ApplicationController

  before_action :authenticate_user!

  def submit
    #ensure that the feedback is for the currently signed in user
    @feedback = Feedback.find_by_id(params[:id])
    if @feedback.try(:user_id) == current_user.id
      @feedback.update(
        rating: params[:feedback_rating].to_i,
        description: params[:feedback_description],
        submitted: true
        )
      render json: {status: 200}
    else
      redirect_to dashboard_path
    end 
  end

  def dismiss
    @feedback = Feedback.find_by_id(params[:id])
    if @feedback.try(:user_id) == current_user.id
      @feedback.update(dismissed: true)
      render json: {status: 200}
    else
      redirect_to dashboard_path
    end

  end

  def index
    @feedbacks = Feedback.open.where(user_id: current_user.id)
  end
end
