module Api
    class V1::PositionsController < V1::ApiBaseController
      before_action :authenticate_user, only: [:destroy, :create, :update]
      before_action :set_resource, only: [:nearby, :destroy, :show, :update]

    def nearby
      radius = 30

      if params.has_key?(:radius)
        radius = params[:radius].to_i
      end

      @positions = @position.nearbys(radius)
      @positions.each do |position|
        position.events = Event.where("position_id = #{position.id} AND application_id = #{@application.id}")
      end
      @show_events = true
      render :index
    end

    def show
      @position.events = Event.where("position_id = #{@position.id} AND application_id = #{@application.id}")
      super
    end

    private
      def position_params
        params.require(:position).permit(:lat, :lng)
      end
  end
end

