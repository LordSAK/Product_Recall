class SearchController < ApplicationController
   before_filter :signed_in_user, only: [:create, :destroy]
   
   def Search
      if ( params[:Searching].nil? or params[:Searching]=="") and (params[:from].nil? or params[:from]=="") and (params[:to].nil? or params[:to]=="") and params[:Category]=="All"
        
        @recalls = Recall.find(:all)   
      elsif ( params[:Searching].nil? or params[:Searching]=="") and (params[:from].nil? or params[:from]=="") and (params[:to].nil? or params[:to]=="") and params[:Category]!="All"
        @Cat=params[:Category]
        @recalls=Recall.find(:all,:conditions=>['"Category" = ?',params[:Category]]) 
      elsif ( !params[:Searching].nil? or params[:Searching]!="") and (params[:from].nil? or params[:from]=="") and (params[:to].nil? or params[:to]=="") and params[:Category]=="All"
        
        @keyword=params[:Searching]
        @recalls = Recall.find(:all, :conditions => ['"Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?',"%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%"])         
      elsif ( !params[:Searching].nil? or params[:Searching]!="") and (params[:from].nil? or params[:from]=="") and (params[:to].nil? or params[:to]=="") and params[:Category]!="All"
        @Cat=params[:Category]
        @keyword=params[:Searching]
        @recalls=Recall.find(:all,:conditions=>['"Category" = ? and ("Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?)',params[:Category],"%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%"])
      elsif ( params[:Searching].nil? or params[:Searching]=="") and (!params[:from].nil? or params[:from]!="") and (!params[:to].nil? or params[:to]!="") and params[:Category]=="All"
        
        @from=Date.strptime params[:from],'%m-%d-%Y'
        @to=Date.strptime params[:to],'%m-%d-%Y'
        @recalls=Recall.find(:all,:conditions=>['"created_at" BETWEEN ? AND ?',@from,@to])
      elsif ( params[:Searching].nil? or params[:Searching]=="") and (!params[:from].nil? or params[:from]!="") and (!params[:to].nil? or params[:to]!="") and params[:Category]!="All"
        @Cat=params[:Category]
        @from=Date.strptime params[:from],'%m-%d-%Y'
        @to=Date.strptime params[:to],'%m-%d-%Y'
        @recalls=Recall.find(:all,:conditions=>['"created_at" BETWEEN ? AND ? and "Category" = ?',@from,@to,params[:Category]])
      elsif ( !params[:Searching].nil? or params[:Searching]!="") and (!params[:from].nil? or params[:from]!="") and (!params[:to].nil? or params[:to]!="") and params[:Category]=="All"
        
        @from=Date.strptime params[:from],'%m-%d-%Y'
        @to=Date.strptime params[:to],'%m-%d-%Y'
        @keyword=params[:Searching]
        @recalls = Recall.find(:all,:conditions=>['"created_at" BETWEEN ? AND ? and ( "Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?)',@from, @to,"%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%"])
      elsif ( !params[:Searching].nil? or params[:Searching]!="") and (!params[:from].nil? or params[:from]!="") and (!params[:to].nil? or params[:to]!="") and params[:Category]!="All"
        @Cat=params[:Category]
        @from=Date.strptime params[:from],'%m-%d-%Y'
        @to=Date.strptime params[:to],'%m-%d-%Y'
        @keyword=params[:Searching]
        @recalls = Recall.find(:all,:conditions=>['"created_at" BETWEEN ? AND ? and "Category" = ? and ( "Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?)',@from, @to,params[:Category],"%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%","%#{@keyword}%"])
      end

    #if !params[:Searching].nil?
    #  @keyword = "Searched  recalls with keyword is '"+ params[:Searching] +"'"
    #end
    if !params[:Searchings].nil?
       @keyword=params[:Searchings]
  	   @recalls = Recall.search(params[:Searchings])
    end
  	#@products = Recall.count(:group => '"Products"')
  	#@hazards = Recall.count(:group => '"Hazards"')
    @Categories=Recall.count(:group => '"Category"')

  	 #    if params[:Category] == "All"
      #      @from=Date.strptime params[:from],'%m/%d/%Y'
       #     @to=Date.strptime params[:to],'%m/%d/%Y'
        #    @keyword = "Searched Recalls from '"+@from.to_s+"' to '"+@to.to_s+"'"
         #   @recalls = Recall.where(:created_at => @from..@to)
         #end

    @trends=Search.all(:select => "searches,count(searches) as cnt",:group => '"searches","created_at"',:order => '"cnt"',:limit => 5)
    if @recalls.nil?
      @search = current_user.searches.build(:searches => @keyword)
      @search.save
    end
         
  end
end
