class SessionsController < ApplicationController
	
	def new
	end

	def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.usertype == 'Basic' && (Date.today - user.created_at.to_datetime)>90
          flash[:message]="your basic subscription period has expired, please upgrade to Pro version"
          new_paypal_url(user.password_reset_token)
      else
        sign_in user
        @history=user.histories.build(:TimeLogin => Time.now.strftime("%d/%m/%Y %H:%M"))
        @history.save
        redirect_back_or "/recalls"
      end
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
