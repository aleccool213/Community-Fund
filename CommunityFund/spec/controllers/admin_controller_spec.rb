require 'rails_helper'

RSpec.describe AdminController, :type => :controller do

  describe "GET analytics" do
    it "returns http success" do
      get :analytics
      expect(response).to have_http_status(:success)
    end
  end

end