class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: [:destroy]
	before_action :correct_user_or_admin, only: [:index]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
		@applications = @user.applications.paginate(page: params[:page])
		@application = @user.applications.build if current_user?(@user)
		#debugger ctrl+D för att fortsätta; We can treat this like a Rails console
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Användaren är borttagen"
		redirect_to users_url
	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params) 
		if @user.save
			log_in @user
			flash[:success] = "Du har registrerat en App!"
			redirect_to @user
		else
			render 'new'
		end
	end
	
	def edit
    	@user = User.find(params[:id])
  	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Uppdaterad"
      		redirect_to @user
		else
			render 'edit'
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Before filters


		# Confirms the correct user.
		def correct_user
			if(!params[:id].nil?)
				@user = User.find(params[:id])
				redirect_to(root_url) unless current_user?(@user)
			else
				redirect_to(root_url)
			end
		end
		
		# Confirms an admin user.
		def admin_user
			redirect_to(root_url) unless is_admin?
		end

		def correct_user_or_admin
			@user = false; 
			if(!params[:id].nil?)
				@user = User.find(params[:id])
			end
			redirect_to(root_url) unless is_admin? || current_user?(@user)
		end
end
