require 'geoip'

class AdminController < ApplicationController
	before_action :authenticate_admin!

	def analytics
		@signups_by_day = add_missing_data(User.group_by_day)
		@projects_by_day = add_missing_data(Project.group_by_day)
		@geo_data = get_geo_data
	end

	private
		# Takes the data and adds entries with value 0 for any missing dates
		def add_missing_data(data)
			# Get oldest entry
			db_date_format = "%Y-%m-%d 00:00:00 UTC"
			min_date_str = data.keys.min || Date.today.strftime(db_date_format)

			# Find missing entries and add them with value 0
			cur_date = Date.parse(min_date_str)
			while cur_date < Time.now
				str_rep = cur_date.strftime("%Y-%m-%d 00:00:00 UTC")
				if not data.has_key? str_rep
					data[str_rep] = 0
				end
				cur_date += 1.day
			end

			return data
		end

		# Return a hash of the form [country_name => num_users] based on the IP
		# address users most recently used to sign in.
		def get_geo_data
			# Look up country by IP address
			geo_db = GeoIP.new('./vendor/assets/other/GeoIP.dat')
			ip_addrs = User.where("last_sign_in_ip is not null").map { |u| u.last_sign_in_ip}
			countries = ip_addrs.map { |ip| geo_db.country(ip).country_name }

			# Massage data into requested Hash
			grouped = countries.group_by{|x|x}.map { |k,v| [k, v.length] }
			data = Hash[*grouped.flatten]

			return data
		end
end
