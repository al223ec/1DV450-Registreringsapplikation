module Api
    class V1::PositionsController < V1::ApiBaseController
        before_action :authenticate_user, only: [:destroy, :create, :update]
        before_action :set_resource, only: [:nearby]

    def nearby
      radius = 30

      if params.has_key?(:radius)
        radius = params[:radius].to_i
      end

      @positions = @position.nearbys(radius)
      @show_events = true
      render :index
    end

    def position_params
      params.require(:position).permit(:lat, :lng)
    end
  end
end

