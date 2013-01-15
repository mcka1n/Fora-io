class AfterRegisterController < ApplicationController
 include Wicked::Wizard
 before_filter :authenticate_user!

 steps :add_zip

 def show
 	@user = current_user
 	render_wizard
 end

 def update
 	@user = current_user
 	#@user.update_attributes(params[:user])
 	@user.first_name = params[:user][:first_name]
 	@user.last_name = params[:user][:last_name]
 	@user.username = params[:user][:username]
 	@user.country = params[:user][:country]
 	@user.state = params[:user][:state]
 	@user.city = params[:user][:city]
 	@user.save


    flash[:message] = "User '#{@user.username}' Updated!"



 	render_wizard @user
 end	

end
