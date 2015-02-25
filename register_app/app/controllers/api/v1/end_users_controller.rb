module Api
	class V1::EndUsersController < V1::ApiBaseController
	    before_action :authenticate_user, only: [:destroy, :update]

		def login
		    end_user = EndUser.find_by(email: params[:end_user][:email].downcase).try(:authenticate, params[:end_user][:password])
		    if end_user
				# Detta är en dålig lösning men får duga för tillfället, 
				# det man skulle ha gjort är unika tokens per user och request och sparat detta i db som
				# man sedan
		    	payload = JWT.encode({ 
		    		end_user_id: end_user.id				
		    		}, @application.name)

				render(:json => { :jwt => payload }, :status => 200)
		    else
		    	respond_with_error("Felaktigt email eller lösenord vg försök igen", :bad_request)
		    end
		end

	    private
			def query_params
				# filter
	        	"application_id = #{@application.id}"
			end

			def end_user_params
				params.require(:end_user).permit(:name, :email, :password, :password_confirmation, :application_id)
			end

			def end_user_simple_params
				params.require(:end_user).permit(:email, :password)
			end
	end
end