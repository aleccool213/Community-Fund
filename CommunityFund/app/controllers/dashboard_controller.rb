class DashboardController < ApplicationController

  before_action :authenticate_user!

  #creates @events instance variable which is a list that stores hashs of different events which fill the dash
  def index
    @events = []

    #Project they are interested in has started, or reached milestones
    current_user.communities.each do |f|
      f.projects.each do |p|
        p.milestones.each do |pj|
          event = Hash.new
          event[:name] = p.name
          event[:type] = "Project"
          event[:type_id] = p.id
          event[:time] = pj.created_at
          event[:description] = pj.description
          @user = User.find(Fund.find(pj.fund_id).user_id)
          @events.push(event)
        end
      end
    end

    #projects located near them has started
    Project.all.each do |p|
      if p.location == current_user.homestate
        event = Hash.new
        event[:name] = p.name
        event[:type] = "Project"
        event[:type_id] = p.id
        event[:description] = "Project has been started in your area!"
        event[:time] = p.created_at
        @events.push(event)
      end
    end

    #people starting discussions on projects this user has started

    #people replying to comments this user has made on other project discussion boards

    #someone gives a rating to a project this user has intiated and project is now finished has ended

    
    @events = @events.sort_by { |k| k[:time] }
    
    @events = @events[0..10]
    @events.reverse!

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
