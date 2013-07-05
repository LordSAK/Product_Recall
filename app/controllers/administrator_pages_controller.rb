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

  def destroy
      Recall.find(params[:id]).destroy
      flash[:success] = "Recall Deleted."
      redirect_to "/recalls"
    end

def edit
  @recall = Recall.find(params[:id])
end

def update
      @recall = Recall.find(params[:id])
      if @recall.update_attributes(params[:recall])
        # Handle a successful update.
        flash[:success] = "Recall updated"
        redirect_to recalls_path
      else
        render 'edit'
      end
    end

    def show
        @user = Recall.find(params[:id])
    end
 
  def home
  end

  def ShiftSubscriber
  end
end