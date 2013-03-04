class DashboardController < ApplicationController
	before_filter :authenticate_user!
	def index
		# @followedByUser = Follow.find(:all, :conditions => {:user_id => current_user.id, :status => 1})
    @followedByUser = Follow.find_all_followed_boards.where(:user_id => current_user.id)
	end

end
