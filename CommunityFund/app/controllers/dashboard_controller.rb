require 'will_paginate/array'
class DashboardController < ApplicationController

  before_action :authenticate_user!

  #creates @dashboard instance variable which is a list that stores hashs of differen  @dashboard which fill the dash
  def index
    @dashboard = []

    #Project they are interested in has started, or reached milestones
    #TODO: bug when projects are apart of two communities and user is interested in more those communities
    current_user.communities.each do |f|
      f.projects.each do |p|
        p.milestones.each do |m|
          if m.milestone_type == "Fund"
            event = {name: p.name, type_id: p.id, time: m.created_at, description: m.description, user_id: Fund.find(m.fund_id).user_id}
            @dashboard.push(event)
          elsif m.milestone_type == "Feedback"
            event = {name: p.name, type_id: p.id, time: m.created_at, description: m.description}
            @dashboard.push(event)
          end
        end
      end
    end

    #projects located near them has started
    Project.all.each do |p|
      if p.location == current_user.homestate #right here tim
        event = {name: p.name, type_id: p.id, description: "Project has been started in your area!", time: p.created_at}
        @dashboard.push(event)
      end
    end

    #someone gives a rating to a project this user has intiated and project is now finished has ended


    @dashboard = @dashboard.sort_by { |k| k[:time] }
    @dashboard.reverse!
    @dashboard = @dashboard.paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html
      format.js
    end

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
