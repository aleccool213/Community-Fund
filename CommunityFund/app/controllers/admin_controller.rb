class AdminController < ApplicationController
	before_action :authenticate_admin!

	def analytics
		@signups_by_day = fix_data(User.group_by_day)
		@projects_by_day = fix_data(Project.group_by_day)
	end

	private
		def fix_data(data)
			cur_date = Date.parse(data.keys.min)
			while cur_date < Time.now
				str_rep = cur_date.strftime("%Y-%m-%d 00:00:00 UTC")
				if not data.has_key? str_rep
					data[str_rep] = 0
				end
				cur_date += 1.day
			end

			return data
		end
end
