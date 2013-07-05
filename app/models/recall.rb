class Recall < ActiveRecord::Base
  attr_accessible :Category, :Details, :Summary, :Time, :Title,:Manufacturer,:Products,:Hazards

	def self.search(search)
		if search
    		find(:all, :conditions => ['"Category" LIKE ? or "Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  		else	
    		find(:all)
  		end
	end

end
