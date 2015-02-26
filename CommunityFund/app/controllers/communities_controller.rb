class CommunitiesController < ApplicationController
  def index
    @communities = Community.active
  end
end
