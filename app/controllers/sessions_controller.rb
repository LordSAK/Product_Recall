class SessionsController < ApplicationController
	
	def new
	end

	def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      @history=user.histories.build(:TimeLogin => Time.now.strftime("%d/%m/%Y %H:%M"))
      @history.save
      redirect_back_or "/recalls"
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

	def destroy
		sign_out
		redirect_to root_url
	end
end
