class AdministratorPagesController < ApplicationController

	include SessionsHelper
	include UsersHelper

  before_filter :signed_in_user, only: [:Recalls, :Recalls1, :Recalls2, :Recalls3, :new,:create,:destroy,:edit,:update,:show]

  def ChangeFeatures
  end

  def Recalls
  	@categories = Recall.select("DISTINCT(\"Category\")")
    #@categories.push('All')
  end

  def Recalls1
    @categories = Recall.select("DISTINCT(\"Category\")")
    #@categories.push('All')
  end

  def Recalls2
    @categories = Recall.select("DISTINCT(\"Category\")")
    #@categories.push('All')
  end


  def Recalls3
    @categories = Recall.select("DISTINCT(\"Category\")")
    #@categories.push('All')
  end 

  def new 
    @recall=Recall.new
  end

  def create
    if params[:recall]
      if params[:recall][:Title] != ""
        @recall=Recall.new(params[:recall])
        if @recall.save
          flash[:success] = "New Recall Added"
          redirect_to "/recalls"
        else
          render "/recalls"        
        end
      else
        flash[:failure]="Provide Title"
        redirect_to "/recalls"
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