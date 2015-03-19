require 'jwt'

module Api
	class V1::ApiBaseController < ApplicationController

		# ref: https://codelation.com/blog/rails-restful-api-just-add-water
		protect_from_forgery with: :null_session
		before_action :authenticate_application

		before_action :set_resource, only: [:destroy, :show, :update]
		before_action :set_new_resource, only:[:create]

		respond_to :json

		rescue_from ActionController::UnknownFormat, with: :missing_format
		rescue_from JWT::DecodeError, with: :not_authorized

		@application
		@end_user

		# POST /{plural_resource_name}
		def create
			if get_resource.save
				render :show, status: :created
			else
				errors = get_resource.errors.full_messages
				respond_with_error("Något har gått fel, #{errors}", :unprocessable_entity)
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
			resources = resource_class.includes(include_params).where(query_params).paginate(page: params[:page], per_page: params[:per_page])
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

		protected
			def set_access_control_headers
				response.headers['Access-Control-Allow-Origin'] = '*'
			 	response.headers['Access-Control-Request-Method'] = '*'
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
			# Om någon extra tabell behöver laddas överlagras denna metod
			def include_params
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
					respond_with_error(resource_name + " med id " + params[:id] + " hittades inte", :not_found)
				end
				instance_variable_set("@#{resource_name}", resource)
			end

			def set_new_resource
				set_resource(resource_class.new(resource_params))
			end

			def authenticate_application
				authenticate_or_request_with_http_token do |token|
					@application = Application.where(key: token).first
					if !@application.nil?
						call = @application.calls.build
						call.ip = request.remote_ip
						call.caller = request.env['HTTP_USER_AGENT']
						call.save # spara request allt verkar bra
						# TODO: Rate Limit och sätta headers
						# X-RATE-LIMIT-LIMIT - antalet anrop inom en tidsperiod
						# X-RATE-LIMIT-REMAINING - återstående anrop
						# X-RATE-LIMIT-RESET - sekunder kvar till nästa "reset"
					end

				end
			end

			def authenticate_user
				@end_user = nil
				jwt = request.headers['HTTP_JWT']
				if jwt
						payload = JWT.decode(jwt, Rails.application.secrets.secret_key_base, "HS512")
						if payload[0]["expiered"] >= Time.now.to_i
  						@end_user = EndUser.find_by(id: payload[0]["end_user_id"])
  					else
  						respond_with_error("Tiden har gått ut för den aktuella jwt vg skaffa en ny", :unauthorized)
  						return
  					end
				end

				if @end_user.nil?
					respond_with_error("Du måste logga in och få ut en 'jwt' som sedan måste skickas med reqesten som en url paramater för att använda denna funktion", :unauthorized)
					return
				elsif @end_user.application_id != @application.id
					respond_with_error("Denna användare tillhör inte den aktuella applikation och requesten kan därför inte genomföras", :unauthorized)
					return
				end
			end # authenticate_user


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


      def missing_format(e)
        respond_with_error("Cannot serve requested format ", :unprocessable_entity)
      end

      def not_authorized
      	respond_with_error("Kan inte parsa jwt, du verkar ha skickat ett ogiltigt värde", :unauthorized)
      end
		end
end
