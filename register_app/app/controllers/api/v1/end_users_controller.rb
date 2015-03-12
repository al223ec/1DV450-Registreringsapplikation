module Api
	class V1::EndUsersController < V1::ApiBaseController
	    before_action :authenticate_user, only: [:destroy, :update]

			rescue_from NoMethodError, with: :error_wrong_credentials

			def login
			    end_user = EndUser.find_by(email: params[:end_user][:email].downcase).try(:authenticate, params[:end_user][:password])
			    if end_user
					# Detta är en sådär lösning men får duga för tillfället,
					# det man skulle ha gjort är unika tokens per user och request och sparat detta i db som man sedan hämtat ut
			    	payload = JWT.encode({
			    		end_user_id: end_user.id,
			    		name: end_user.name,
			    		email: end_user.email,
			    		created_at: end_user.created_at,
			    		expiered: 2.hours.from_now.to_i,
			    		}, Rails.application.secrets.secret_key_base, "HS512")

						render(:json => { :jwt => payload }, :status => 200)
			    else
						error_wrong_credentials
			    end
			end

			def create
				@end_user.application = @application
				super
			end

	    private
	    # @return [Hash]
				def query_params
		   		{ application_id: @application.id}
				end

				def end_user_params
					params.require(:end_user).permit(:name, :email, :password, :password_confirmation, :application_id)
				end

				def end_user_simple_params
					params.require(:end_user).permit(:email, :password)
				end

				def error_wrong_credentials
					respond_with_error("Felaktigt email eller lösenord vg försök igen", :unauthorized)
				end
	end
end
