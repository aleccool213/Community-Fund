class FeedbacksController < ApplicationController

  before_action :authenticate_user!

  def submit

  end

  def

  def dismiss

  end

  def show
    @feedback = Feedback.not_dismissed.where(user_id: current_user.id)
  end
end
