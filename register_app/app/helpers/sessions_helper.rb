module SessionsHelper
	
	def log_in(api_user)
		session[:api_user_id] = api_user.id
	end
	
	# Remembers a user in a persistent session.
	def remember(api_user)
		api_user.remember
		cookies.permanent.signed[:api_user_id] = api_user.id
		cookies.permanent[:remember_token] = api_user.remember_token
	end
	
	# Returns true if the given user is the current user.
	def current_user?(api_user)
		api_user == current_user
	end

	def current_user_or_admin?(api_user)
		!api_user.nil? && api_user.admin? || api_user == current_user
	end

	# Returns the user corresponding to the remember token cookie or the session
	def current_user
		if (api_user_id = session[:api_user_id])
			@current_user ||= ApiUser.find_by(id: api_user_id)
		elsif (api_user_id = cookies.signed[:api_user_id])	
			api_user = ApiUser.find_by(id: api_user_id)
			if (api_user && api_user.authenticated?(cookies[:remember_token]))
				log_in api_user
				@current_user = api_user
			end
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def is_admin?
		!current_user.nil? && current_user.admin? 
	end

	# Forgets a persistent session.
	def forget(api_user)
		api_user.forget
		cookies.delete(:api_user_id)
		cookies.delete(:remember_token)
	end

	def log_out
		forget(current_user)
    	session.delete(:api_user_id)
    	@current_user = nil
  	end


  	# Redirects to stored location (or to the default).
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# Stores the URL trying to be accessed.
	def store_location
		session[:forwarding_url] = request.url if request.get?
	end
end	
