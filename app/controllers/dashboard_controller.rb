class DashboardController < ApplicationController
	before_filter :authenticate_user!
	def index
		@followedByUser = Follow.find(:all, :conditions => {:user_id => 1})
		
	end

end
