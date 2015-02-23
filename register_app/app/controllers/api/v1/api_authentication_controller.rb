
class Api::V1::ApiAuthenticationController < Api::V1::ApiBaseController
	before_action :authenticate_application

    @application

    def index
		plural_resource_name = "@#{resource_name.pluralize}"
	  	resources = resource_class.where("application_id = ?", @application.id).paginate(page: params[:page], per_page: params[:per_page])
		instance_variable_set(plural_resource_name, resources)
	  	respond_with instance_variable_get(plural_resource_name)  
	end

	private
		def authenticate_application
			authenticate_or_request_with_http_token do |token, options|
				@application = Application.where(key: token).first
				
				if !@application.nil?
					call = @application.calls.build
					call.ip = request.remote_ip
					call.caller = request.env['HTTP_USER_AGENT'] 
					call.save # spara request allt verkar bra
				end
			end
		end
end
