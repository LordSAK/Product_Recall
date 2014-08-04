class Recall < ActiveRecord::Base
	set_primary_key :id 
  attr_accessible :Category, :Details, :Summary, :Time, :Title,:Manufacturer,:Products,:Hazards
 # default_scope -> { order('created_at DESC') }
	def self.search(search)
		if search
    		find(:all, :conditions => ['"Category" LIKE ? or "Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  		else	
    		find(:all)
  		end
	end

	def self.searchall(keyword,from,to,category)
		find(:all,:conditions=>['"created_at" BETWEEN ? AND ? and "Category" = ? or "Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?',"{from}","{to}","{category}","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
	end

	def self.searchkeyBetween(keyword,from,to)
		find(:all,:conditions=>['"created_at" BETWEEN ? AND ? and or "Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?',"{from}","{to}","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
	end

	def self.searchkeyinCat(keyword,category)
		find(:all,:conditions=>['"Category" = ? or "Details" LIKE ? or "Summary" LIKE ? or "Title" LIKE ? or "Manufacturer" LIKE ? or "Products" LIKE ? or "Hazards" LIKE ?',"{category}","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
	end

	def self.searchBetween(from,to)
		find(:all,:conditions=>['"created_at" BETWEEN ? AND ?',"{from}","{to}"])
	end

	def self.searchBetweeninCat(from,to,category)
		find(:all,:conditions=>['"created_at" BETWEEN ? AND ? and "Category" = ?',"{from}","{to}","{category}"])
	end

	def self.searchingCat(category)
		find(:all,:conditions=>['"Category" LIKE ?',"%#{category}%"])
	end

	require 'net/http'
	def self.all
		if Recall.where(:Category => 'Consumer Products').blank?
			url = URI.parse('http://www.recalls.gov/rrcpsc.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date
			
			#	if !@line.nil?	
			
				#@times=@timeonsite.to_time
			#		if @date < @line
				@SummaryAll=i.partition(') ')[2]
				@summary=@SummaryAll.partition('</p>')[0]


				uris=i.partition('href="')[2]
				uri=uris.partition('" target="_blank"')[0]
				url1 = URI.parse(uri)
				@req1 = Net::HTTP::Get.new(url1.path)
				@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}
					#@htmlofPage.push(@res1.body)

				@h1all=@res1.body.partition('<h1>')[2]
				@titleofRecall=@h1all.partition('</h1>')[0]
			

				@HazardAll=@res1.body.partition('Hazard:</span>')[2]
				@HazardAfterPara=@HazardAll.partition('<p>')[2]
				@Hazard=@HazardAfterPara.partition('</p>')[0]

				@DescriptionAll=@res1.body.partition('Description</h5>')[2]
				@Description=@DescriptionAll.partition('<h5>')[0]
				@RecallBasic.push('title: '+ @h1all+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)


				@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
				@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
				@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
				@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

				Recall.create(:Category => "Consumer Products", :Details => @Description, :Summary => @summary, :Title => @titleofRecall, :Hazards => @Hazard)

			end
		else

			@date=Recall.where(:Category => 'Consumer Products').last.created_at.to_date
			url = URI.parse('http://www.recalls.gov/rrcpsc.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}
			puts("SAK")

			@RecallBasic=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date
			
				if !@line.nil?	
			
				#@times=@timeonsite.to_time
					if @date < @line
						@SummaryAll=i.partition(') ')[2]
						@summary=@SummaryAll.partition('</p>')[0]


						uris=i.partition('href="')[2]
						uri=uris.partition('" target="_blank"')[0]
						url1 = URI.parse(uri)
						@req1 = Net::HTTP::Get.new(url1.path)
						@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}
					#@htmlofPage.push(@res1.body)

						@h1all=@res1.body.partition('<h1 data-description="page-title">')[2]
						@titleofRecall=@h1all.partition('</h1>')[0]
					

						@HazardAll=@res1.body.partition('Hazard:</span>')[2]
						@HazardAfterPara=@HazardAll.partition('<p>')[2]
						@Hazard=@HazardAfterPara.partition('</p>')[0]

						@DescriptionAll=@res1.body.partition('Description</h5>')[2]
						@Description=@DescriptionAll.partition('<h5>')[0]

						@RecallBasic.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)


						@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

						Recall.create(:Category => "Consumer Products", :Details => @Description, :Summary => @summary, :Title => @titleofRecall, :Hazards => @Hazard)

					end
				end
			end	
		end
		###################End of Get Data from CPSC site#######################


		#################Begin Get data from FDA site Food Drugn Cosmetics##########################
		if Recall.where(:Category => 'Foods, Medicines, Cosmetics').blank?
			url = URI.parse('http://www.recalls.gov/rrfda.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic1=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date
			
	#			if !@line.nil?	
			
				#@times=@timeonsite.to_time
	#			if @date < @line
				@SummaryAll=i.partition(') ')[2]
				@summary=@SummaryAll.partition('</p>')[0]

				uris=i.partition('href="')[2]
				uri=uris.partition('" target="_blank"')[0]
				url1 = URI.parse(uri)
				@req1 = Net::HTTP::Get.new(url1.path)
				@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}
					#@htmlofPage.push(@res1.body)

				@h1all=@res1.body.partition('<title>')[2]
				@titleofRecall=@h1all.partition('</title>')[0]
					#@titleofRecall=@res1.body

				#	@HazardAll=@res1.body.partition('Hazard:</span>')[2]
				#	@HazardAfterPara=@HazardAll.partition('<p>')[2]
				#	@Hazard=@HazardAfterPara.partition('</p>')[0]

				@DescriptionAll=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
					#@DescriptionAfterH5=@DescriptionAll.partition('<p style=" text-align: center;">###')[0]
					#@Description=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
					

				if @DescriptionAll.include? '<p style=" text-align: center;">###'
					@Description=@DescriptionAll.partition('<p style=" text-align: center;">###')[0]
				elsif @DescriptionAll.include? "<p>###"
					@Description=@DescriptionAll.partition('<p>###')[0]
				elsif @DescriptionAll.include? '<p style="text-align: center">###'
						@Description=@DescriptionAll.partition('<p style="text-align: center">###')[0]
				end



					#@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)
				@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,,Description:'+@Description)

				@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
				@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
				@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

				Recall.create(:Category => "Foods, Medicines, Cosmetics", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)
			end	
		else
			@date=Recall.where(:Category => 'Foods, Medicines, Cosmetics').last.created_at.to_date
			url = URI.parse('http://www.recalls.gov/rrfda.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic1=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date
			
				if !@line.nil?	
			
				#@times=@timeonsite.to_time
					if @date < @line
						@SummaryAll=i.partition(') ')[2]
						@summary=@SummaryAll.partition('</p>')[0]


						uris=i.partition('href="')[2]
						uri=uris.partition('" target="_blank"')[0]
						url1 = URI.parse(uri)
						@req1 = Net::HTTP::Get.new(url1.path)
						@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}
					#@htmlofPage.push(@res1.body)

						@h1all=@res1.body.partition('<title>')[2]
						@titleofRecall=@h1all.partition('</title>')[0]
					#@titleofRecall=@res1.body

				#	@HazardAll=@res1.body.partition('Hazard:</span>')[2]
				#	@HazardAfterPara=@HazardAll.partition('<p>')[2]
				#	@Hazard=@HazardAfterPara.partition('</p>')[0]

						@DescriptionAll=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
					#@DescriptionAfterH5=@DescriptionAll.partition('<p style=" text-align: center;">###')[0]
					#@Description=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
					

						if @DescriptionAll.include? '<p style=" text-align: center;">###'
							@Description=@DescriptionAll.partition('<p style=" text-align: center;">###')[0]
						elsif @DescriptionAll.include? "<p>###"
							@Description=@DescriptionAll.partition('<p>###')[0]
						elsif @DescriptionAll.include? '<p style="text-align: center">###'
								@Description=@DescriptionAll.partition('<p style="text-align: center">###')[0]
						elsif @DescriptionAll.include? '<div class="text-center">###</div>'
							@Description=@DescriptionAll.partition('<div class="text-center">###</div>')[0]							
						end



					#@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)
						@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,,Description:'+@Description)

						@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

						Recall.create(:Category => "Foods, Medicines, Cosmetics", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)

					end
				end
			end	
		end
		####################end of get data from FDA site####################

		######################start of get data from NHTSA site Vehicles Recalls##############
		if Recall.where(:Category => 'Motor Vehicles').blank?
			url = URI.parse('http://blogs.cars.com/kickingtires/recalls/')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic2=Array.new

			@arr=@res.body.split('<div class="entry" id="entry-')
			@arr.compact.each do |i|
				@j=i.partition('</a> |')[2] 
				@timeonsite=@j.partition('| <a')[0]
				@line=@timeonsite.to_date

				if i.include? 'Recall Alert:'
                    @titleAll=i.partition('Recall Alert: ')[2]
                    @titleofRecall=@titleAll.partition('</a></h3>')[0]
                else
                	@titleAll=i.partition('<h3 class="entry-header"><a href="')[2]
                    @titleofRecall=@titleAll.partition('</a></h3>')[0]
                    @titleofRecall=@titleofRecall.partition('">')[2]
			    end 


				if i.include? 'Read More'
					@urlAll=i.partition('href="')[2]
					@urlwithhref=@urlAll.partition('">')[0]

					uri= @urlwithhref
					url1 = URI.parse(uri)
					@res1=Net::HTTP.start(url1.host, url1.port) do |http|
						http.get(url1.request_uri)
					end

					@DescriptionAll=@res1.body.partition('<div class="entry-body">')[2]
					if  @DescriptionAll.include? '<p><a href="'
						@Description=@DescriptionAll.partition('<p><a href="')[0]
					elsif	@DescriptionAll.include? '<p><strong><a href="'
						@Description=@DescriptionAll.partition('<p><strong><a href="')[0]
					end
				else
					@DescriptionAll=i.partition('<div class="entry-body">')[2]
					if @DescriptionAll.include? 'More Recalls'
						if @DescriptionAll.include? '<p><strong><a href="' 
							@Description=@DescriptionAll.partition('<p><strong><a href="')[0]	
						else
							@Description=@DescriptionAll.partition('<p><a href="')[0]
						end
					else
						@Description=@DescriptionAll.partition('</div>')[0]
					end				
				end

				if @Description.include? '<p><strong>Related'
					@Description=@Description.partition('<p><strong>Related')[0]
				end

				if @Description.include? '<strong>Related</strong>'
					@Description=@Description.partition('<strong>Related</strong>')[0]
				end

						if @Description.include? '</div>'
							@Description['</div>']=' '
						end

				@RecallBasic2.push("Title:"+@titleofRecall+",,,,,,,Description:"+@Description)

			@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
			#@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
			#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
			@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
			Recall.create(:Category => "Motor Vehicles", :Details => @Description, :Title => @titleofRecall)
				
			end		
		else
			@date=Recall.where(:Category => 'Motor Vehicles').last.created_at.to_date
			url = URI.parse('http://blogs.cars.com/kickingtires/recalls/')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic2=Array.new


			@arr=@res.body.split('<div class="entry" id="entry-')
			@arr.compact.each do |i|

				@j=i.partition('</a> |')[2] 
				@timeonsite=@j.partition('| <a')[0]
				@line=@timeonsite.to_date

				if !@line.nil?

					if @date < @line
						 if i.include? 'Recall Alert:'
						 	@titleAll=i.partition('Recall Alert: ')[2]
						 	@titleofRecall=@titleAll.partition('</a></h3>')[0]
						 else
						 	@titleAll=i.partition('<h3 class="entry-header"><a href="')[2]
						 	@titleofRecall=@titleAll.partition('</a></h3>')[0]
						 	@titleofRecall=@titleofRecall.partition('">')[2]
						 end 

						 if i.include? 'Read More'
						 	@urlAll=i.partition('href="')[2]
						 	@urlwithhref=@urlAll.partition('">')[0]

						 	uri= @urlwithhref
						 	url1 = URI.parse(uri)
						 	@res1=Net::HTTP.start(url1.host, url1.port) do |http|
						 		http.get(url1.request_uri)
						 	end

							@DescriptionAll=@res1.body.partition('<div class="entry-body">')[2]
							if  @DescriptionAll.include? '<p><a href="'
								@Description=@DescriptionAll.partition('<p><a href="')[0]
							elsif	@DescriptionAll.include? '<p><strong><a href="'
								@Description=@DescriptionAll.partition('<p><strong><a href="')[0]
							end

						else
							@DescriptionAll=i.partition('<div class="entry-body">')[2]
							if @DescriptionAll.include? 'More Recalls'
								if @DescriptionAll.include? '<p><strong><a href="' 
									@Description=@DescriptionAll.partition('<p><strong><a href="')[0]
								else
									@Description=@DescriptionAll.partition('<p><a href="')[0]
								end
							else
								@Description=@DescriptionAll.partition('</div>')[0]
							end				
						end

						if @Description.include? '<p><strong>Related'
							@Description=@Description.partition('<p><strong>Related')[0]
						end

						if @Description.include? '<strong>Related</strong>'
							@Description=@Description.partition('<strong>Related</strong>')[0]
						end

						if @Description.include? '</div>'
							@Description['</div>']=' '
						end

						@RecallBasic2.push("Title:"+@titleofRecall+",,,,,,,Description:"+@Description)

						@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						#@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						Recall.create(:Category => "Motor Vehicles", :Details => @Description, :Title => @titleofRecall)
					end
				end		
			end	
		end
		##################### end of get data from NHTSA site #####################
		###############start of get data from Meat and Poultry Products FSIS site#############
		if Recall.where(:Category => 'Meat and Poultry Products').blank?
			url = URI.parse('http://www.recalls.gov/rrusda.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic3=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date
			
				@SummaryAll=i.partition(') ')[2]
				@summary=@SummaryAll.partition('</p>')[0]


				uris=i.partition('href="')[2]
				uri=uris.partition('" target="_blank"')[0]
				if !uri.include? '&#xA;'
					url1 = URI.parse(uri)
					@req1 = Net::HTTP::Get.new(url1.path)
					@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}

					@h1all=@res1.body.partition('<h3 class="recall-title-header">')[2]
					@titleofRecall=@h1all.partition('</h3>')[0]

					@DescriptionAll=@res1.body.partition('<div class="recall-body">')[2]

					if @DescriptionAll.include? '<p>FSIS and the company'
				 		@Description=@DescriptionAll.partition('<p>FSIS and the company')[0]
					elsif @DescriptionAll.include? "<p>FSIS has received no reports of"
						@Description=@DescriptionAll.partition('<p>FSIS has received no reports of')[0]
					#	elsif @DescriptionAll.include? '<p style="text-align: center">###'
					#			@Description=@DescriptionAll.partition('<p style="text-align: center">###')[0]
					end
					
					@RecallBasic3.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,,Description:'+@Description)

					@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

					Recall.create(:Category => "Meat and Poultry Products", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)

				end
			end
		else
			@date=Recall.where(:Category => 'Meat and Poultry Products').last.created_at.to_date
			url = URI.parse('http://www.recalls.gov/rrusda.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic3=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date

				if !@line.nil?
					if @date < @line
						@SummaryAll=i.partition(') ')[2]
						@summary=@SummaryAll.partition('</p>')[0]

						uris=i.partition('href="')[2]
						uri=uris.partition('" target="_blank"')[0]
						if !uri.include? '&#xA;'
							url1 = URI.parse(uri)
							@req1 = Net::HTTP::Get.new(url1.path)
							@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}
							
							@h1all=@res1.body.partition('<h3 class="recall-title-header">')[2]
							@titleofRecall=@h1all.partition('</h3>')[0]

							@DescriptionAll=@res1.body.partition('<div class="recall-body">')[2]
							
							if @DescriptionAll.include? '<p>FSIS and the company'
								@Description=@DescriptionAll.partition('<p>FSIS and the company')[0]
							elsif @DescriptionAll.include? "<p>FSIS has received no reports of"
								@Description=@DescriptionAll.partition('<p>FSIS has received no reports of')[0]
							elsif @DescriptionAll.include? '<p>Consumers with questions about'
								@Description=@DescriptionAll.partition('<p>Consumers with questions about')[0]
							end
							
							if @titleofRecall.nil?
								@titleofRecall=''
							end
							if @summary.nil?
								@summary=''
							end
							if @Description.nil?
								@Description=''
							end
							@RecallBasic3.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,,Description:'+@Description)

							@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
							@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
							#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
							@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

							Recall.create(:Category => "Meat and Poultry Products", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)

						end
					end
				end
			end
		end
		######################end of get data from FSIS site######################

		##################start of get data from uscg boating for Boats and Boating Safety################

		if Recall.where(:Category => 'Boats and Boating Safety').blank?

		#@date=Recall.where(:Category => 'Meat and Poultry Products').last.created_at.to_date
			url = URI.parse('http://www.recalls.gov/rruscg.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic4=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date
			
				#if !@line.nil?	
			
				#@times=@timeonsite.to_time
				#if @date < @line
				@SummaryAll=i.partition(') ')[2]
				@summary=@SummaryAll.partition('</p>')[0]
					
				@TitleAll=i.partition('target="_blank">')[2]
				@titleofRecall=@TitleAll.partition('</a>')[0]
				
				uris=i.partition('href="')[2]
				uri=uris.partition('" target="_blank"')[0]
				

					url1 = URI.parse(uri)
					
					@res1=Net::HTTP.start(url1.host, url1.port) do |http|
						http.get(url1.request_uri)
					end

					
					@DescriptionAll=@res1.body.partition('<td colspan="3" style="padding-top:20px;">')[2]
					@Description=@DescriptionAll.partition('</td>')[0]


					#@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)
					@RecallBasic4.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,,,,,Description:'+@Description)

					@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
			
					Recall.create(:Category => "Boats and Boating Safety", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)

				
			end
			#end	
		else
			@date=Recall.where(:Category => 'Boats and Boating Safety').last.created_at.to_date
			url = URI.parse('http://www.recalls.gov/rruscg.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic4=Array.new

			@arr=@res.body.split("<p>")
			@arr.compact.each do |i|
				@j=i.partition('</a> (')[2] 
				@timeonsite=@j.partition(')')[0]
				@line=@timeonsite.to_date

				if !@line.nil?
					#@times=@timeonsite.to_time
					if @date < @line
						@SummaryAll=i.partition(') ')[2]
						@summary=@SummaryAll.partition('</p>')[0]
					
						@TitleAll=i.partition('target="_blank">')[2]
						@titleofRecall=@TitleAll.partition('</a>')[0]
				
						uris=i.partition('href="')[2]
						uri=uris.partition('" target="_blank"')[0]
						
						url1 = URI.parse(uri)
					
						@res1=Net::HTTP.start(url1.host, url1.port) do |http|
							http.get(url1.request_uri)
						end

					
						@DescriptionAll=@res1.body.partition('<td colspan="3" style="padding-top:20px;">')[2]
						@Description=@DescriptionAll.partition('</td>')[0]


					#@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)
						@RecallBasic4.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,,,,,Description:'+@Description)

						@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
						@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
			
						Recall.create(:Category => "Boats and Boating Safety", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)

						
					end
				end
			end
		end

		################# end of get data from uscg boating site#########################
		usersFinallist=Array.new
		@AllRecall=@RecallBasic | @RecallBasic1 | @RecallBasic2 | @RecallBasic3 | @RecallBasic4
		@users=User.all
		@AllRecall.each do |str|
			@users.each do |u|
				@vendor=Vendor.select(:vendor).where("user_id=?",u.id)
				@vendor.each do |v|
					if str.include? v.vendor
						usersFinallist.push(u.email)

					end
				end
			end
		end
		usersFinallist= usersFinallist & usersFinallist
		usersFinallist.each do |email|
			puts email
			Emailer.contact(email,"New recalls are added","New recalls have been added to site related to the keywords you registered. Login into site http://localhost:3000/ to view latest recalls. Have a good day!").deliver
		end
	end
end