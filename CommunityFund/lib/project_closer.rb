class ProjectCloser
  # TODO close out all projects whose daedlines have been met. This includes changing their activity status, sending out review notifications or whatever the hell you want
  # TODO test this
  def self.close
    Project.active.where("completion_date < ?", DateTime.now).find_each(batch_size: 100) do |project|
      # TODO - just call update(open: false)? There has to be a better way of doing this
      project.open = false
      # TODO send notifications to gather feedback from user

      project.save
    end
  end
end