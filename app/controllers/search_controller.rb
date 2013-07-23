class SearchController < ApplicationController
   before_filter :signed_in_user, only: [:create, :destroy]
   
   def Search
    if !params[:Searching].nil?
      @keyword = "Searched  recalls with keyword is '"+ params[:Searching] +"'"
    end
  	@recalls = Recall.search(params[:Searching])
  	@products = Recall.count(:group => '"Products"')
  	@hazards = Recall.count(:group => '"Hazards"')
  	if !params[:from].nil? and !params[:to].nil?
  	   @from=Date.strptime params[:from],'%m/%d/%Y'
  	   @to=Date.strptime params[:to],'%m/%d/%Y'
       @keyword = "Searched Recalls from '"+@from.to_s+"' to '"+@to.to_s+"'"
  	   @recalls = Recall.where(:created_at => @from..@to)
  	end
    @trends=Search.all(:select => "searches,count(searches) as cnt",:group => '"searches","created_at"',:order => '"cnt"',:limit => 5)
    if @recalls.any?
      @search = current_user.searches.build(:searches => @keyword)
      @search.save
    end
  end
end
