class ApplicationsController < ApplicationController
	#Väldigt bra namngivning från min sida
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :current_user_is_creator_or_admin,   only: :destroy	

	def create
		@application = current_user.applications.build(application_params)

		if @application.save
			flash[:success] = "Din applikation och dess nyckel har skapats!"
			redirect_to root_url
		else
			@applications = []
			render 'static_pages/home'
		end
	end

	def destroy
		@application.destroy
		flash[:success] = "Applikationen och dess nyckel är borttagen!"
		redirect_to request.referrer || root_url
	end

	private
		def application_params
			params.require(:application).permit(:name)
		end

		def current_user_is_creator_or_admin
			if current_user.admin? 
				@application = Application.find_by(id: params[:id]);
			else
				@application = current_user.applications.find_by(id: params[:id])
			end

			if 	@application.nil?
				flash[:error] = "Något oväntat har gått fel, applikationen kan inte hittas i databasen"
				redirect_to root_url
			end
		end

end
