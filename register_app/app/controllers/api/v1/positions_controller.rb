module Api
    class V1::PositionsController < V1::ApiBaseController
        before_action :authenticate_user, only: [:destroy, :create, :update]
    end

    def event_params
      params.require(:position).permit(:lat, :lng)
    end
end

