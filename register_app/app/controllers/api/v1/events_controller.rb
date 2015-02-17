
class Api::V1::EventsController < Api::V1::ApiBaseController
	# http://railsware.com/blog/2013/04/08/api-with-ruby-on-rails-useful-tricks/
	# If you want your API to be fast (and I bet you do) then you should consider using ActionController::Metal.
	# include ActionController::Rendering        # enables rendering
	# include ActionController::MimeResponds     # enables serving different content types like :xml or :json
	# include AbstractController::Callbacks      # callbacks for your authentication logic
    
    # Exempel på det som behöver implementeras
    private
    	#def album_params
        	#params.require(:album).permit(:title)
      	#end
		#def query_params
        	# this assumes that an album belongs to an artist and has an :artist_id
        	# allowing us to filter by this
        	#params.permit(:artist_id, :title)
		#end
end
