class HistoriesController < ApplicationController
   before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]

   def show
    if params[:id].nil?
      @user=current_user
      flash[:success]=@user
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
      @history = @user.histories.paginate(page: params[:page])

      data_table = GoogleVisualr::DataTable.new 
      # Add Column Headers

      data_table.new_column('string', 'Days' )
      data_table.new_column('number', 'Login')
      #data_table.new_column('number', 'Expenses')


      @historys=ActiveRecord::Base.connection.select_rows('SELECT DATE("TimeLogin") AS d, COUNT(*) AS c FROM histories GROUP BY DATE("TimeLogin");')
      #@historys1=current_user.histories.where("date(created_at) > ?", 1.days.ago).group("date(created_at)").count
      #@historys2=current_user.histories.where("date(created_at) > ?", 2.days.ago).group("date(created_at)").count
      #@historys3=current_user.histories.where("date(created_at) > ?", 3.days.ago).group("date(created_at)").count
      # Add Rows and Values
      #data_table.add_rows([
      #  ['2004', 1000],
      #  ['2005', 1170],
      #  ['2006', 660],
      #  ['2007', 1030]
      #]) 
      data_table.add_rows(@historys.map)

      option = { width: 400, height: 240, title: 'Login Frequency' }
      @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
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
      @history = @user.histories.paginate(page: params[:page])

      data_table = GoogleVisualr::DataTable.new 
      # Add Column Headers
      data_table.new_column('string', 'Days' )
      data_table.new_column('number', 'Login')
      #data_table.new_column('number', 'Expenses')


     #@historys=ActiveRecord::Base.connection.select_rows('SELECT DATE("TimeLogin") AS d, COUNT(*) AS c FROM histories GROUP BY DATE("TimeLogin");')
      @items=History.where(:user_id => params[:id]).count(:group => "DATE(\"TimeLogin\"),DATE(\"created_at\")")

      #@historys = @items.group_by{|n| n.last}.each_with_object({}){|(k, g), h| h[k] = g.size}
      #@historys1=current_user.histories.where("date(created_at) > ?", 1.days.ago).group("date(created_at)").count
      #@historys2=current_user.histories.where("date(created_at) > ?", 2.days.ago).group("date(created_at)").count
      #@historys3=current_user.histories.where("date(created_at) > ?", 3.days.ago).group("date(created_at)").count
      # Add Rows and Values
      #data_table.add_rows([
      #  ['2004', 1000],
      #  ['2005', 1170],
      #  ['2006', 660],
      #  ['2007', 1030]
      #]) 
      #data_table.add_rows(@historys.map)

      option = { width: 400, height: 240, title: 'Login Frequency' }
      @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
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
    @history = current_user.histories.paginate(page: params[:page])

    data_table = GoogleVisualr::DataTable.new 
    # Add Column Headers
    data_table.new_column('string', 'Days' )
    data_table.new_column('number', 'Login')
    #data_table.new_column('number', 'Expenses')


    @historys=ActiveRecord::Base.connection.select_rows('SELECT DATE("TimeLogin") AS d, COUNT(*) AS c FROM histories GROUP BY DATE("TimeLogin");')
    #@historys1=current_user.histories.where("date(created_at) > ?", 1.days.ago).group("date(created_at)").count
    #@historys2=current_user.histories.where("date(created_at) > ?", 2.days.ago).group("date(created_at)").count
    #@historys3=current_user.histories.where("date(created_at) > ?", 3.days.ago).group("date(created_at)").count
    # Add Rows and Values
    #data_table.add_rows([
    #  ['2004', 1000],
    #  ['2005', 1170],
    #  ['2006', 660],
    #  ['2007', 1030]
    #]) 
    data_table.add_rows(@historys)

    option = { width: 400, height: 240, title: 'Login Frequency' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option) 



  end

  def new
    @historiess=History.new
  end


  def create
  	@History = current_user.histories.build(params[:histories])
    if @history.save
      flash[:success] = "History created!"
      redirect_to root_url
    else
      @History_feed_items = []
      render 'users/home'
    end
  end

  def destroy
  end

  #private

   #   def supplier_params
    #  params.require(:supplier).permit(:supplier[])
    #end
end