class AdminFeatureController < ApplicationController
before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
before_filter :admin_user,     only: :destroy

  def edit
  	@admin=current_user
  end

  
def update
    @user=current_user
  	if @user.update_attribute(:Advance_Search_allow, params[:user][:Advance_Search_allow]) and 
      @user.update_attribute(:paid_Alert,params[:user][:paid_Alert]) and
      @user.update_attribute(:basic_Alert,params[:user][:basic_Alert])
      sign_in @user
  	  flash[:success] = "Settings updated"
      redirect_to '/recalls'
    else
     	flash[:success]=@user.errors.full_messages
	  end
    
  end
end
