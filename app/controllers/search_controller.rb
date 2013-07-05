class SearchController < ApplicationController
  
  def Search
  	@recalls = Recall.search(params[:Searching])
  	@products = Recall.count(:group => '"Products"')
  	@hazards = Recall.count(:group => '"Hazards"')
  	if !params[:from].nil? and !params[:to].nil?
  		@from=Date.strptime params[:from],'%m/%d/%Y'
  		@to=Date.strptime params[:to],'%m/%d/%Y'
  		@recalls = Recall.where(:created_at => @from..@to)
  	end

  end

end
