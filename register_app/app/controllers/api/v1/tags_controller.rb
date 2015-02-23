class Api::V1::TagsController < Api::V1::ApiBaseController
	def index
		#TODO: returnera all taggar i systemet
		plural_resource_name = "@#{resource_name.pluralize}"
	  	resources = resource_class.paginate(page: params[:page], per_page: params[:per_page])
		instance_variable_set(plural_resource_name, resources)
	  	respond_with instance_variable_get(plural_resource_name)
	end
end
