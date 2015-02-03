class DashboardController < ApplicationController

  before_action :authenticate_user!

  def index

  end

  def collect_information
    # to be displayed after user signup
    if current_user.communities.length >= 1
      redirect_to dashboard_path
    end

    @communities = Community.active
    @collect_information_form = ::CollectInformationForm.new(user: current_user, communities: @communities)
  end

  def submit_information
    @communities = Community.active
    @collect_information_form = ::CollectInformationForm.new(user: current_user, communities: @communities)
    @collect_information_form.submit(params[:collect_information_form])

    # if we can't find hometown, just add a flash error for when they are redirected on the dashboard
    flash[:notice] = "Communities Updated!"
    redirect_to dashboard_path
  end
end
