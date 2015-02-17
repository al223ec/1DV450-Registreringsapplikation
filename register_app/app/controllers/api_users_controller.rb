class ApiUsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: [:destroy]
	before_action :correct_user_or_admin, only: [:index]

	def index
		@api_users = ApiUser.paginate(page: params[:page])
	end

	def show
		@api_user = User.find(params[:id])
		@applications = @api_user.applications.paginate(page: params[:page])
		@application = @api_user.applications.build if current_user?(@api_user)
		#debugger ctrl+D för att fortsätta; We can treat this like a Rails console
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Användaren är borttagen"
		redirect_to api_users_url
	end
	
	def new
		@api_user = ApiUser.new
	end

	def create
		@api_user = ApiUser.new(user_params) 
		if @api_user.save
			log_in @api_user
			flash[:success] = "Du har registrerat en användare, nu kan du skapa en applikation och få ut en api nyckel!"
			redirect_to @api_user
		else
			render 'new'
		end
	end
	
	def edit
    	@api_user = ApiUser.find(params[:id])
  	end

	def update
		@api_user = ApiUser.find(params[:id])
		if @api_user.update_attributes(user_params)
			flash[:success] = "Uppdaterad"
      		redirect_to @api_user
		else
			render 'edit'
		end
	end

	private
		def user_params
			params.require(:api_user).permit(:name, :email, :password, :password_confirmation)
		end

		# Before filters

		# Confirms the correct user.
		def correct_user
			if(!params[:id].nil?)
				@api_user = ApiUser.find(params[:id])
				redirect_to(root_url) unless current_user?(@api_user)
			else
				redirect_to(root_url)
			end
		end
		
		# Confirms an admin user.
		def admin_user
			redirect_to(root_url) unless is_admin?
		end

		def correct_user_or_admin
			@api_user = false; 
			if(!params[:id].nil?)
				@api_user = ApiUser.find(params[:id])
			end
			redirect_to(root_url) unless is_admin? || current_user?(@api_user)
		end
end
