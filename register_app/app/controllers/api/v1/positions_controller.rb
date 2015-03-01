module Api
    class V1::PositionsController < V1::ApiBaseController
        before_action :authenticate_user, only: [:destroy, :create, :update]

    def show
      if @position.geocoded?
        @position.nearbys(30)                      # other objects within 30 miles
        @position.distance_from([40.714,-100.234]) # distance from arbitrary point to object
        @position.bearing_to("Paris, France")      # direction from object to arbitrary point
        #debugger
      end
      super
    end

    def position_params
      params.require(:position).permit(:lat, :lng)
    end
  end
end

