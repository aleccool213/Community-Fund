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

  def events
    #feed goes here
      #information about (to do): 
      # -projects starting near them
      # -people starting discussions on projects the user has started, people replying to the users comments
      # -if someone rates a project they have intiated

      # How this will be implemented:
      # -big array of cards which will be filled in with the different 'events'
      # as described above and will be sorted by time

      #projects nearing different points in their overall funding, eg, "project x made it to 20%!"

    events = []

    #project events
    for i in current_user.communities.projects.each
      event = Hash.new
      event[name: i.name]
      event[type: "Project"]
      event[type_id: i.id]
      #if its still open, get status
      if i.closed == false
        event[description: i.completion_status]
        #if project has been created recently, just sort this event by the time the project was created
        if event[description] = "Project has been created! (0-25% funded)"
          event[time: i.created_at]
        else
          #event[time: ] todo: make function to return the time in which the status was reached
          events.push(event)
        end
      #if closed, get when it finished
      else
        event[description: "Project has been funded! (100%)"]
        #event[time: ] todo: add in function to return completion time
        events.push(event)
      end
    end

    for i in Projects.all
      if i.location == current_user.homestate
        event = Hash.new
        event[name: i.name]
        event[type: "Project"]
        event[type_id: i.id]
        event[description: "Project has been started in your area!"]
        event[time: i.created_at]
    end

    



  events.sort do |a, b| b[time] <=> a[time] end 
  end
end
