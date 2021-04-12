class ProfileController < ApplicationController
  before_action :authenticate_user!
	def index
			@profiles = current_user.recipes.all
	end
end
