module Api
    class V1::EventsController < V1::ApiBaseController
        before_action :authenticate_user, only: [:destroy, :create, :update]

        # Denna metod överlagras för att den är unik iom att user_id och application id ska tilldelas
        # samt taggarna hanteras
        def create
            @event.end_user_id = @end_user.id
            @event.application_id = @application.id

            save_tags
            super
        end

        def update
            save_tags
            super
        end

        def query
            if queries = params[:queries]
                sql = ''
                query_hash = {}
                # Osäker hur säkert detta är, men att parmatisera brukar vara ok
                queries.each do | query |
                    sql << "AND content LIKE :q#{query} "
                    query_hash[:"q#{query}"] = "%#{query}%"
                end

                @events = Event.where("application_id = #{@application.id} " << sql, query_hash).paginate(page: params[:page], per_page: params[:per_page])
                render :index
            else
                render json: "Felaktigt formaterade parametrar", status: :unprocessable_entity
            end
        end

        private
            # nås via resource_params i bas klassen
        	def event_params
            	params.require(:event).permit(:content, :position_id)
          	end

            def query_params
                # filter
                if !params[:end_user_id].nil?
                    # om man når denna kontroller via /end_user/:id/events
                    user_id = params[:end_user_id].to_i
                    { application_id: @application.id, end_user_id: user_id }
                elsif !params[:tag_id].nil?
                    # om man når denna kontroller via /tags/:id/events
                    tag_id = params[:tag_id].to_i
                    { tags: { id: tag_id }, application_id: @application.id }
                else
                    # om man når denna kontroller via /events/
                    { application_id: @application.id}
                end
            end

            def include_params
                :tags
            end

            def save_tags
                @event.tags = []
                tags = params[:tags]

                if tags
                    tags.each do | tag |
                        tagInDb = Tag.find_by(name: tag["name"].downcase)
                        if tagInDb.nil?
                            @event.tags.build(name: tag["name"])
                        else
                            # existing = EventTag.where("tag_id = #{tagInDb.id} AND event_id = #{@event.id}").nil?
                            # if EventTag.where("tag_id = #{tagInDb.id} AND event_id = #{@event.id}").nil? || @event.id.nil?
                            @event.tags << tagInDb
                            #end
                        end
                    end
                end
            end
        end
    end
