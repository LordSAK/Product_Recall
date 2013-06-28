class AdministratorPagesController < ApplicationController

	include SessionsHelper
	include UsersHelper

	
  def ChangeFeatures
  end

  def Recalls
  	@categories = Recall.select("DISTINCT(\"Category\")")
  end

  def new 
    @recall=Recall.new
  end

  def create
    if params[:recall]
      @recall=Recall.new(params[:recall])
      if @recall.save
        flash[:success] = "New Recall Added"
        redirect_to "/recalls"
      else
        render "/recalls"        
      end
    end
  end



  def ShiftSubscriber
  end
end
