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

  # Returns a list of events which pertain to the logged in user.
  # Specifically returns a list of hashes with the attributes in the hashes
  #being information about an event.

  def events
    
    #projects nearing different points in their overall funding, eg, "project x made it to 20%!"

    events = []

    #Project they are interested in has started, or reached milestones
    for i in current_user.communities.projects.each
      project_milestones = i.milestones
      for x in project_milestones
        event = Hash.new
        event['name' => i.name]
        event['type' => "Project"]
        event['type_id' => i.id]
        event['time' => x.created_at]
        event['description' => x.description]
      end
    end

    #projects located near them has started
    for i in Projects.all
      if i.location == current_user.homestate
        event = Hash.new
        event['name' => i.name]
        event['type' => "Project"]
        event['type_id' => i.id]
        event['description' => "Project has been started in your area!"]
        event['time' => i.created_at]
      end
    end

    #people starting discussions on projects this user has started

    #people replying to comments this user has made on other project discussion boards

    #someone gives a rating to a project this user has intiated and project is now finished has ended

    



  events.sort do |a, b| b[time] <=> a[time] end 
  end
end
