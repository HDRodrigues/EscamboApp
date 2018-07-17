class Members::SessionsController < Devise::SessionsController
  protected
    def after_sign_in_path_for(resource)
    	# Get the last page 
      stored_location = stored_location_for(resource)
      # If last page match with the pattern
      if stored_location.match(site_ad_detail_index_path)
      	# Redirect to last page
      	stored_location
      else
      	# Redirect to index dasboard
		    site_profile_dashboard_index_path
		  end
    end
end

