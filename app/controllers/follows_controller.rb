class FollowsController < ApplicationController

 def index
  @follows = Follow.all
 end

	
end
