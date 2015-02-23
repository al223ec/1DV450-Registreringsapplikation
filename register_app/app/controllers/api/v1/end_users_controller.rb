module Api
	class V1::EndUsersController < V1::ApiBaseController
	    before_action :authenticate_user, only: [:destroy, :update]

		def login
		    end_user = EndUser.find_by(email: params[:email].downcase)
		    if end_user && end_user.authenticate(params[:password])
		    	payload = JWT.encode({
				  end_user_id: end_user.id,
				}, @application.key)

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
				params.require(:end_user).permit(:name, :email, :password, :password_confirmation)
			end
	end
end