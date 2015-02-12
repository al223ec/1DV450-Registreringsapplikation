class Api::V1::EventsController < ActionController::Base
	# http://railsware.com/blog/2013/04/08/api-with-ruby-on-rails-useful-tricks/
	# If you want your API to be fast (and I bet you do) then you should consider using ActionController::Metal.
	# include ActionController::Rendering        # enables rendering
	# include ActionController::MimeResponds     # enables serving different content types like :xml or :json
	# include AbstractController::Callbacks      # callbacks for your authentication logic
	respond_to :json

	
	def show
		respond_with User.find(params[:id])
	end
end
