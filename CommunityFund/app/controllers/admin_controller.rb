require 'geoip'

class AdminController < ApplicationController
	before_action :authenticate_admin!

	def analytics
		@signups_by_day = fix_data(User.group_by_day)
		@projects_by_day = fix_data(Project.group_by_day)
		@geo_data = get_geo_data
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

		def get_geo_data
			geo_db = GeoIP.new('./vendor/assets/other/GeoIP.dat')
			ip_addrs = User.where("last_sign_in_ip is not null").map { |u| u.last_sign_in_ip}
			countries = ip_addrs.map { |ip| geo_db.country(ip).country_name }
			grouped = countries.group_by{|x|x}.map { |k,v| [k, v.length] }
			data = Hash[*grouped.flatten]

			return data
		end
end
