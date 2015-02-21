class Milestone < ActiveRecord::Base
	belongs_to :project

	def description
		if self.percentage == 0.01
			"Project has been created! (0-25% funded)"
		elsif self.percentage == 0.25
			"Project is starting to shape up! (Over 25% funded)"
		elsif self.percentage == 0.50
			"Project is half way there! (Over 50% funded)"
		elsif self.percentage == 0.75
			"Project is almost funded! (Over 75% funded)"
		elsif self.percentage == 1
			"Project has been funded! :D (Over 100% funded)"
		end
	end
end
