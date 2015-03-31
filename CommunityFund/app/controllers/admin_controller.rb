require 'geoip'

class AdminController < ApplicationController
	before_action :authenticate_admin!

	autocomplete :user, :username

	def analytics
		@signups_by_day = add_missing_data(User.group_by_day)
		@projects_by_day = add_missing_data(Project.group_by_day)
		@geo_data = get_geo_data
	end

	def settings
		@admins = User.where('admin = ?', true)
	end

	def update_admins
		# Get list of existing admins and given new list of admins
		old_usernames = User.where('admin = ?', true).map { |u| u.username.downcase }
		new_usernames = params[:usernames].map { |u| u.downcase }

		# Figure out which users should have admin status granted or revoke
		to_grant = new_usernames - old_usernames
		to_revoke = old_usernames - new_usernames

		# Execute request
		to_grant.each do |username|
			user = User.find_by! username: username
			user.admin = true
			user.save!
		end

		to_revoke.each do |username|
			user = User.find_by! username: username
			user.admin = false
			user.save!
		end

		redirect_to admin_settings_path
	end

	def moderation
		all_reports = Report.all

		project_reports = process_reports(all_reports, :project)
		@projects = project_reports.map { |proj_id, count| [Project.find_by_id(proj_id), count] }
	end

	private
		# Takes the data and adds entries with value 0 for any missing dates
		def add_missing_data(data)
			# Get oldest entry
			date_format = '%Y-%m-%d 00:00:00 UTC'
			min_date_str = data.keys.min || Date.today.strftime(date_format)

			# Find missing entries and add them with value 0
			cur_date = Date.parse(min_date_str)
			while cur_date < Time.now
				str_rep = cur_date.strftime(date_format)
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
			geo_db = GeoIP.new(Rails.root.join('vendor', 'assets', 'other', 'GeoIP.dat'))
			ip_addrs = User.where('last_sign_in_ip is not null').map { |u| u.last_sign_in_ip}
			countries = ip_addrs.map { |ip| geo_db.country(ip).country_name }

			# Massage data into requested Hash
			grouped = countries.group_by{|x|x}.map { |k,v| [k, v.length] }
			data = Hash[*grouped.flatten]

			return data
		end

		# Filter reports by given, and group by the object id
		def process_reports(reports, obj_type)
			filtered = reports.select { |r| r.reported_obj_type == obj_type.to_s }
			grouped = filtered.group_by { |r| r.reported_obj_id }
			counted = grouped.map { |g, r| [g, r.length] }
			sorted = counted.sort_by { |a| a[1] }.reverse

			return sorted
		end
end
