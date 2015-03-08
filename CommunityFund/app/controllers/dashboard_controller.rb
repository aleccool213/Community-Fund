require 'will_paginate/array'
class DashboardController < ApplicationController

  before_action :authenticate_user!

  #creates @dashboard instance variable which is a list that stores hashs of differen  @dashboard which fill the dash
  def index
    @dashboard = []

    #Project they are interested in has started, or reached milestones

    #grab all communities, grab all *unique* projects
    unique_projects = []

    current_user.communities.each do |f|
      f.projects.each do |p|
        if unique_projects.include?(p) == false
          unique_projects << p
        end
      end
    end

    unique_projects.each do |p|
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

    #projects located near them has started
    Project.near_user(current_user).each do |p|
      event = {name: p.name, type_id: p.id, description: "Project has been started in your area!", time: p.created_at}
      @dashboard.push(event)
    end

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
