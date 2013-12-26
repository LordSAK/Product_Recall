class VendorsController < ApplicationController
   before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]

   def show
    if params[:id].nil?
      @user=current_user
      if !@user.FirstName.blank?
        @user_name= @user.FirstName
      else
        @user_name= ''
      end
      if !@user.LastName.blank?
        @user_name= @user_name+" "+@user.LastName
      else
        @user_name= @user_name+ ''
      end
      @vendor = current_user.vendors.paginate(page: params[:page])
    else
      @user=User.find(params[:id])
      if !@user.FirstName.blank?
        @user_name= @user.FirstName
      else
        @user_name= ''
      end
      if !@user.LastName.blank?
        @user_name= @user_name+" "+@user.LastName
      else
        @user_name= @user_name+ ''
      end
      @vendor = current_user.vendors.paginate(page: params[:page])
    end
   end

  def index
   @user=current_user
   if !@user.FirstName.blank?
      @user_name= @user.FirstName
    else
      @user_name= ''
    end
    if !@user.LastName.blank?
      @user_name= @user_name+" "+@user.LastName
    else
      @user_name= @user_name+ ''
    end
   @vendor = current_user.vendors.paginate(page: params[:page])
  end

  def new
    @vendors=Vendor.new    
  end


  def create
    if current_user.usertype=="Basic"
      basic_count=User.select("\"basic_keyword\"").where("\"id\"=1")
      count=current_user.vendors.count
      if count < basic_count.first.basic_keyword
        @vendor = current_user.vendors.build(params[:vendors])
        if @vendor.save
          flash[:success] = "Vendor created!"
          redirect_to '/vendors'
        else
          @vendor_feed_items = []
          redirect_to '/vendors'
        end
      else
        flash[:failure]= "you can't add more keywords."
        redirect_to '/vendors'
      end
    elsif current_user.usertype=="Paid"
      pro_count=User.select("\"paid_keyword\"").where("\"id\"=1")
      count=current_user.vendors.count
      if count <= pro_count
        @vendor = current_user.vendors.build(params[:vendors])
        if @vendor.save
          flash[:success] = "Vendor created!"
          redirect_to '/vendors'
        else
          @vendor_feed_items = []
          redirect_to '/vendors'
        end
      else
        flash[:failure]= "you can't add more keywords."
        redirect_to '/vendors'
      end
    end
  end


  def destroy
  end

	private

      def vendor_params
      params.require(:vendor).permit(:vendor[])
    end
end