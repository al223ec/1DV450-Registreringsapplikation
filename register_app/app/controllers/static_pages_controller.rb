class StaticPagesController < ApplicationController
  def home
  	@application = current_user.applications.build if logged_in?
  	@applications = current_user.get_applications.paginate(page: params[:page]) if logged_in?
  end

  def about
  end
end
