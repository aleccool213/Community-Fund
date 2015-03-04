class CommunitiesController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @communities = Community.active
  end

  def show

  end
end
