module Api
    class V1::EventsController < V1::ApiBaseController
        before_action :authenticate_user, only: [:destroy, :create, :update]
        # Denna metod överlagras för att den är unik iom att user_id och application id ska tilldelas
        # samt taggarna hanteras
        def create
            set_resource(resource_class.new(resource_params))

            @event.end_user_id = @end_user.id
            @event.application_id = @application.id

            save_tags
            if @event.save
                render :show, status: :created
            else
                errors = @event.errors.full_messages
                respond_with_error("Något har gått fel, #{errors}", :unprocessable_entity)
            end
        end

        def update
            save_tags
            if @event.update(params.require(:event).permit(:content, :position_id))
                render :show
            else
                errors = @event.errors.full_messages
                respond_with_error("Något har gått fel, #{errors}", :unprocessable_entity)
            end
        end

        private

        	def event_params
            	params.require(:event).permit(:content, :position_id)
          	end

            def query_params
                # filter
                if !params[:end_user_id].nil?
                    # om man når denna kontroller via /end_user/:id/events
                    user_id = params[:end_user_id].to_i
                    "application_id = #{@application.id} and end_user_id = #{user_id}"
                elsif !params[:tag_id].nil?
                    # om man når denna kontroller via /tags/:id/events
                    tag_id = params[:tag_id].to_i
                    {tags: { id: tag_id }}
                else
                    # om man når denna kontroller via /events/
                    {application_id: @application.id}
                end
            end

            def include_params
                :tags
            end

            def save_tags
                if @event.tags.nil?
                    @event.tags = []
                end

                tags = params[:event][:tags]
                if tags

                    tags.each do | index, tag |
                        tagInDb = Tag.find_by(name: tag)
                        if tagInDb.nil?
                            @event.tags.build(name: tag)
                        else
                            if EventTag.where("tag_id: #{tagInDb.id} AND event_id: #{@event.id}").nil? || @event_id.nil?
                                @event.tags << tagInDb
                            end
                        end
                    end
                end
            end
        end
    end
