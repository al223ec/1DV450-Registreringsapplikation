class Api::V1::EventsController < ActionController::Base
	# http://railsware.com/blog/2013/04/08/api-with-ruby-on-rails-useful-tricks/
	# If you want your API to be fast (and I bet you do) then you should consider using ActionController::Metal.
	# include ActionController::Rendering        # enables rendering
	# include ActionController::MimeResponds     # enables serving different content types like :xml or :json
	# include AbstractController::Callbacks      # callbacks for your authentication logic

	respond_to :json
	
	def show
		application = Application.find_by(key: params[:id])
		respond_with application
	end

	private 
		def respond_with_errormessage(message)
		end
end
