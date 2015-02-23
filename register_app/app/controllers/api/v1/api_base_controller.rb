require 'jwt'

module Api
	class V1::ApiBaseController < ApplicationController
		
		# ref: https://codelation.com/blog/rails-restful-api-just-add-water
		protect_from_forgery with: :null_session
		before_action :authenticate_application
	    before_action :set_resource, only: [:destroy, :show, :update] 

	    respond_to :json

	    @application
	    @end_user

		# POST /{plural_resource_name}
		def create
		  	set_resource(resource_class.new(resource_params))

			if get_resource.save
		    	render :show, status: :created
		  	else
				render json: get_resource.errors, status: :unprocessable_entity
			end
		end

		# DELETE /{plural_resource_name}/1
		def destroy
			get_resource.destroy
			head :no_content
		end

		# GET /{plural_resource_name}
		def index
			plural_resource_name = "@#{resource_name.pluralize}"
		  	resources = resource_class.where(query_params).paginate(page: params[:page], per_page: params[:per_page])
			instance_variable_set(plural_resource_name, resources)
		  	respond_with instance_variable_get(plural_resource_name)  
		end

		# GET /api/{plural_resource_name}/1
		def show
			respond_with get_resource
		end

		# PATCH/PUT /api/{plural_resource_name}/1
		def update
			if get_resource.update(resource_params)
				render :show
			else
				render json: get_resource.errors, status: :unprocessable_entity
			end
		end

	    private
			# Returns the resource from the created instance variable
			# @return [Object]
			def get_resource
				instance_variable_get("@#{resource_name}")
			end

			# Returns the allowed parameters for searching
			# Override this method in each API controller
			# to permit additional parameters to search on
			# @return [Hash]
			def query_params
				{}
			end

			# Returns the allowed parameters for pagination
			# @return [Hash]
			def page_params
				params.permit(:page, :page_size)
			end

			# The resource class based on the controller
			# @return [Class]
			def resource_class
				@resource_class ||= resource_name.classify.constantize
			end

			# The singular name for the resource class based on the controller
			# @return [String]
			def resource_name
				@resource_name ||= self.controller_name.singularize
			end

			# Only allow a trusted parameter "white list" through.
			# If a single resource is loaded for #create or #update,
			# then the controller for the resource must implement
			# the method "#{resource_name}_params" to limit permitted
			# parameters for the individual model.
			def resource_params
				@resource_params ||= self.send("#{resource_name}_params")
			end

			# Use callbacks to share common setup or constraints between actions.
			def set_resource(resource = nil)
				resource ||= resource_class.find_by(id: params[:id])
				if !resource
					respond_with_error(
						resource_name + " med id " + params[:id] + " hittades inte", 
						:not_found)
				end

				instance_variable_set("@#{resource_name}", resource)
			end

			def authenticate_application
				authenticate_or_request_with_http_token do |token|

					@application = Application.where(key: token).first

					if !@application.nil?
						call = @application.calls.build
						call.ip = request.remote_ip
						call.caller = request.env['HTTP_USER_AGENT'] 
						call.save # spara request allt verkar bra
					end
					#debugger
				end
			end

			def authenticate_user
				if params[:jwt]
					# Detta är en dålig lösning men får duga för tillfället
					payload = JWT.decode(params[:jwt], @application.key)
	  				@end_user = EndUser.find(payload["end_user_id"])

	  				!@end_user.nil?
				end
			end


			def respond_with_error(message, status)
				render(:json => { 
					:error => 1, 
					:message => message, 
					:method => request.method, 
					:request_url => request.original_url,
					:query_parameters => request.query_parameters 
					}, 
					:status => status)
				return # behövs detta?  
			end
		end
end