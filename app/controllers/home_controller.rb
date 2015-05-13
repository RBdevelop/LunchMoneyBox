class HomeController < ApplicationController

	def index
  	
  	if parent_signed_in?
  		redirect_to dashboard_overview_path
  	else
  		redirect_to new_parent_session_path
  	end
 
  end

end
