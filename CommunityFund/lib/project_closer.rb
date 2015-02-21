class ProjectCloser
  # TODO close out all projects whose daedlines have been met. This includes changing their activity status, sending out review notifications or whatever the hell you want
  # TODO test this
  def self.close
    Project.open.where("completion_date < ?", DateTime.now).find_each(batch_size: 100) do |project|
      project.close_project
    end
  end
end