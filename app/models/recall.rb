class Recall < ActiveRecord::Base
  attr_accessible :Category, :Details, :Summary, :Time, :Title,:Manufacturer,:Products,:Hazards

	def self.search(search)
		if search
    		find(:all, :conditions => ['"LOWER(Category)" LIKE ? or "LOWER(Details)" LIKE ? or "LOWER(Summary)" LIKE ? or "LOWER(Title)" LIKE ? or "LOWER(Manufacturer)" LIKE ? or "LOWER(Products)" LIKE ? or "LOWER(Hazards)" LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%"])
  		else	
    		find(:all)
  		end
	end

end
