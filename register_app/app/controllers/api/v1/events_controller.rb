
class Api::V1::EventsController < Api::V1::ApiBaseController
	# http://railsware.com/blog/2013/04/08/api-with-ruby-on-rails-useful-tricks/
	# If you want your API to be fast (and I bet you do) then you should consider using ActionController::Metal.
	# include ActionController::Rendering        # enables rendering
	# include ActionController::MimeResponds     # enables serving different content types like :xml or :json
	# include AbstractController::Callbacks      # callbacks for your authentication logic

	
	
	#def show
		#application = Application.find_by(key: params[:id])
		
		#if application.nil? 
		#	respond_with_errormessage("Felaktig nyckel din tomte!")
		#	return
		#end

		# call = @application.calls.build
		# call.ip = request.remote_ip
		# call.caller = request.env['HTTP_USER_AGENT'] 
		# call.save # spara request

		#respond_with @application
	#end

	private 
	# http://futureshock-ed.com/2011/03/04/http-status-code-symbols-for-rails/
		def respond_with_errormessage(message)
			render :json => { :error => 1, :message => message }, :status => :bad_request
		end
end
