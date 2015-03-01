class SessionsController < ApplicationController
  def new 
    # Serve view plz
  end

  def create
    api_user = ApiUser.find_by(email: params[:session][:email].downcase)
    if api_user && api_user.authenticate(params[:session][:password])
		  log_in api_user
      params[:session][:remember_me] == '1' ? remember(api_user) : forget(api_user)
      redirect_back_or api_user
    else
		  flash.now[:danger] = 'Ogitig email/lösenords kombination'
    	render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
