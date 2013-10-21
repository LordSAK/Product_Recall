class VendorsController < ApplicationController
   before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]


  def index
   @user=current_user
   @vendor = current_user.vendors.paginate(page: params[:page])
  end

  def new
    @vendors=Vendor.new    
  end


  def create
  	@vendor = current_user.vendors.build(params[:vendors])
    if @vendor.save
      flash[:success] = "Vendor created!"
      redirect_to root_url
    else
      @vendor_feed_items = []
      render 'users/home'
    end
  end

  def destroy
  end

	private

      def vendor_params
      params.require(:vendor).permit(:vendor[])
    end
end