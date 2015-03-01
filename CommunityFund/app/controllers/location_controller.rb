class LocationController < ApplicationController
	respond_to :json

	def countries
		render json: GeoInfo::countries.to_json
	end

	def cities
		# Check if request format is valid
		if not params.has_key? :country_id
			render json: { errors: 'Request missing country_id' }, status: 400
			return
		end

		# Get cities, verify result
		cities = GeoInfo::cities_for_country params[:country_id]
		if cities.blank?
			render json: { errors: 'No such country_id' }, status: 404
			return
		end

		render json: cities.to_json
	end
end
