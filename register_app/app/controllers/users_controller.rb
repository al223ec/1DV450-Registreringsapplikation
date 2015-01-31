class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #debugger ctrl+D för att fortsätta; We can treat this like a Rails console
  end

  def new
	@user = User.new
  end
end
