class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def index
    @communities = Community.active
  end

  def show
    @community = Community.find(params[:id])
  end

  def edit
    @community = Community.find(params[:id])
  end

  def update
    @community = Community.find(params[:id])

    params.permit!
    if @community.update(params[:community])
      redirect_to @community
    else
      render :action => 'edit'
    end
  end
end
