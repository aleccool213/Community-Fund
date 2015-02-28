class LocationController < ApplicationController
	respond_to :json

	def countries
		db_query = "SELECT DISTINCT name FROM country_details ORDER BY name"
		@countries ||= city_database.query db_query
		render json: @countries.to_json
	end

	def cities
		# Check if request format is valid
		if not params.has_key? :country
			render json: { errors: 'Request missing country' }, status: 400
			return
		end

		# Check if requested country is valid
		db_query = 'SELECT id, city FROM cities WHERE country = ? ORDER BY city'
		cities = city_database.query(db_query, [params[:country]]).to_json
		if cities == [].to_json
			render json: { errors: 'No such country' }, status: 404
			return
		end

		# Get cities
		render json: cities
	end

	private
		def city_database
			db_path = File.join(Rails.root, 'vendor', 'assets', 'other', 'Cities.dat')
			@database ||= SQLite3::Database.open db_path
		end
end
