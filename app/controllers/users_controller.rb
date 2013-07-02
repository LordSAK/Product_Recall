class UsersController < ApplicationController

before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
before_filter :correct_user,   only: [:edit, :update]
before_filter :admin_user,     only: :destroy

	def show
    	@user = User.find(params[:id])
  	end

  	def new
  		 @user = User.new
  	end

  	def create
  		@user = User.new(params[:user])
  		if @user.save
        sign_in @user
        if params[:theme] == 'Paid'
          redirect_to paypal_payment_path(@user) #This could be your another action in your controller where you may need to initiate something and redirect to paypal 
          return 
        else
          flash[:success] = "Welcome to Product Recall!"
          redirect_to "/recalls"
        end
        else
  	   		render 'new'
    	end
  	end

    def paypal_payment_path(return_path)
      values={
        :business => 'saghir.alam-facilitator@musewerx.com ',
        :cmd => '_cart',
        :upload => '1',
        :return => return_path,
        :invoice => id
      }
      "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=V4JWJJNZMFZW2"
    end


    def index
      @users = User.paginate(page: params[:page])
    end

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end

    def edit
      #@user = User.find(params[:id])
    end

    def update
      #@user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        # Handle a successful update.
        flash[:success] = "Profile updated"
        sign_in @user
        redirect_to @user
      else
        render 'edit'
      end
    end

    private

   def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end