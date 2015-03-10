class ProjectCloser

  def self.close
    Project.open.where("completion_date < ?", DateTime.now).find_each(batch_size: 100) do |project|
      project.close!
    end
  end

  # for testing and development only! close a specific project!
  def self.close_project(id)
    Project.try(:find, id).try(:close!)
  end
end