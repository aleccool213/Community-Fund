class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  respond_to :json
  
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

  def join
    # Check if community exists
    community_id = params[:community_id]
    community = Community.find_by_id(community_id)
    if community.blank?
      render json: { errors: 'Community not found' }, status: 404
      return
    end

    # Join Community
    community.users << current_user

    render json: @community.users
  end

end
