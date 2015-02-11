class AdminController < ApplicationController
	before_action :authenticate_admin!

	def analytics
	end
end
