require 'rails_helper'

RSpec.describe FeedbacksController, :type => :controller do
  context "submit" do
    it "should submit a feedback" do
      sign_in create(:user)
      feedback = FactoryGirl.create(:feedback, user: User.last, project: FactoryGirl.create(:project))

      post :submit, id: feedback.id, feedback_rating: 10, feedback_description: "A decent time"

      expect(response).to be_success
      expect(Feedback.last.submitted?).to eq(true)
      expect(Feedback.last.rating).to eq(10)
      expect(Feedback.last.description).to eq("A decent time")
    end

    it "should redirect to dashboard if feedback does not exist" do
      sign_in create(:user)

      post :submit, id: 0, feedback_rating: 10, feedback_description: "A decent time"

      expect(response).to redirect_to dashboard_path
    end
  end

  context "dismiss" do
    it "should dismiss a feedback" do
      sign_in create(:user)
      feedback = FactoryGirl.create(:feedback, user: User.last, project: FactoryGirl.create(:project))

      post :dismiss, id: feedback.id

      expect(response).to be_success
      expect(Feedback.last.submitted?).to eq(false)
      expect(Feedback.last.dismissed?).to eq(true)
    end

    it "should redirect to dashboard if feedback does not exist" do
      sign_in create(:user)
      feedback = FactoryGirl.create(:feedback, user: User.last, project: FactoryGirl.create(:project))

      post :dismiss, id: 0

      expect(response).to redirect_to dashboard_path
    end
  end
end
