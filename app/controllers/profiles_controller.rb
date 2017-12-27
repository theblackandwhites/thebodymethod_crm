class ProfilesController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def pay_online_only
  	@user = User.find(params[:profile_id])

	if @user.update_attributes(:pay_online_only => params[:completed])
		#@user.update_attributes(pay_online_only: true)
	else
		#@user.update_attributes(pay_online_only: false)
	end

  end

end
