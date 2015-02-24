module Api
	class V1::TagsController < V1::ApiBaseController
		before_action :authenticate_user, only: [:destroy, :create, :update] 
		
		private 
	    	def tag_params
				params.require(:tag).permit(:name)
			end

			def query_params
	            # filter
	            "id != 0"
	        end
	end
end
