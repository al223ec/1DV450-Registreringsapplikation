module Api
    class V1::EventsController < V1::ApiBaseController
        before_action :authenticate_user, only: [:destroy, :create, :update] 
        
        private
        	def event_params
            	params.require(:event).permit(:content, :position_id, :tags => [])
          	end

            def query_params
                # filter
                if params[:end_user_id].nil?
                    "application_id = #{@application.id}"
                else
                    "application_id = #{@application.id} and end_user_id = #{params[:end_user_id]}"
                end
            end
        end
    end
