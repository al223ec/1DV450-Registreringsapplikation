class Api::V1::EndUsersController < Api::V1::ApiBaseController

	def login
	    end_user = EndUser.find_by(email: params[:email].downcase)
	    if end_user && end_user.authenticate(params[:session][:password])
			log_in end_user
			redirect_back_or end_user
	    else
	    	respond_with_error("Felaktigt email eller lösenord vg försök igen", :bad_request)

	    end
	end    

    private
    	#def album_params
        	#params.require(:album).permit(:title)
      	#end
		def query_params
        	# this assumes that an album belongs to an artist and has an :artist_id
        	# allowing us to filter by this
        	# params.permit(:artist_id, :title)
		end

		def user_params
			params.require(:end_user).permit(:name, :email, :password, :password_confirmation)
		end
end
