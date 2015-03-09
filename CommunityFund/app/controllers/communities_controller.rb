class CommunitiesController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @communities = Community.active
  end

  def show
  	@community = Community.find(params[:id])
  end
end
