class LocationController < ApplicationController
	respond_to :json

	def countries
		@countries ||= Location.uniq.order(:country_code).pluck(:country_code)
		render json: @countries.to_json
	end

	def cities
		# Check if request format is valid
		if not params.has_key? :country
			render json: { errors: 'Request missing country' }, status: 400
			return
		end

		# Check if requested country is valid
		cities = Location.where(['country_code = ?', params[:country]]).order(:asciiname).pluck(:asciiname)
		if cities.blank?
			render json: { errors: 'No such country' }, status: 404
			return
		end

		# Get cities
		render json: cities.to_json
	end
end
