class SuppliersController < ApplicationController
   before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]


  def index
    @user=current_user
    @supplier = current_user.suppliers.paginate(page: params[:page])
  end

  def new
    @suppliers=Supplier.new
  end


  def create
  	@supplier = current_user.suppliers.build(params[:suppliers])
    if @supplier.save
      flash[:success] = "Supplier created!"
      redirect_to root_url
    else
      @supplier_feed_items = []
      render 'users/home'
    end
  end

  def destroy
  end

  private

      def supplier_params
      params.require(:supplier).permit(:supplier[])
    end
end