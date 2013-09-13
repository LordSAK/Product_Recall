class UpdateController < ApplicationController
	require 'net/http'
	def All
		###############Get data from CPSC site Consumer Products Recall######################
		if Recall.where(:Category => 'Foods, Medicines, Cosmetics').blank?
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
				@RecallBasic.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)


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

						@h1all=@res1.body.partition('<h1>')[2]
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
		#@date=Recall.where(:Category => 'Motor Vehicles').last.created_at.to_date
		#url = URI.parse('http://www.recalls.gov/rrvehicles.aspx')
		#@req = Net::HTTP::Get.new(url.path)
		#@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

		#@RecallBasic2=Array.new

		#@arr=@res.body.split("<p>")
		#@arr.compact.each do |i|
			#@j=i.partition('</a> (')[2] 
#			@timeonsite=@j.partition(')')[0]
#			@line=@timeonsite.to_date
#			
#			if !@line.nil?	
#			
				#@times=@timeonsite.to_time
#				if @date < @line
#					@SummaryAll=i.partition(') ')[2]
#					@summary=@SummaryAll.partition('</p>')[0]


#					uris=i.partition('href="')[2]
#					uri=uris.partition('" target="_blank"')[0]
#					uri=uri.gsub /&amp;/, "&"
#					url1 = URI.parse(uri)
					
#					@res1=Net::HTTP.start(url1.host, url1.port) do |http|
#						http.get(url1.request_uri)
#						end
						#@htmlofPage.push(@res1.body)

					#@h1all=@res1.body.partition('<title>')[2]
#					@titleofRecall=@h1all.partition('</title>')[0]
#						@titleofRecall=@res1.body
					
				#	@HazardAll=@res1.body.partition('Hazard:</span>')[2]
				#	@HazardAfterPara=@HazardAll.partition('<p>')[2]
				#	@Hazard=@HazardAfterPara.partition('</p>')[0]

#					@DescriptionAll=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
					#@DescriptionAfterH5=@DescriptionAll.partition('<p style=" text-align: center;">###')[0]
					#@Description=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
					

#					if @DescriptionAll.include? '<p style=" text-align: center;">###'
#						@Description=@DescriptionAll.partition('<p style=" text-align: center;">###')[0]
#					elsif @DescriptionAll.include? "<p>###"
#						@Description=@DescriptionAll.partition('<p>###')[0]
#					elsif @DescriptionAll.include? '<p style="text-align: center">###'
#							@Description=@DescriptionAll.partition('<p style="text-align: center">###')[0]
#					end



					#@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)
					#@RecallBasic2.push('Summary: '+@summary)
#					@RecallBasic2.push(@titleofRecall)

#					@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
#					@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
#					@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

#					Recall.create(:Category => "Foods, Medicines, Cosmetics", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)
#				end
#			end
#		end	
		##################### end of get data from NHTSA site #####################

		###############start of get data from Meat and Poultry Products FSIS site#############
		if Recall.where(:Category => 'Meat and Poultry Products').blank?

		#@date=Recall.where(:Category => 'Meat and Poultry Products').last.created_at.to_date
			url = URI.parse('http://www.recalls.gov/rrusda.aspx')
			@req = Net::HTTP::Get.new(url.path)
			@res = Net::HTTP.start(url.host, url.port) {|http|  http.request(@req)}

			@RecallBasic3=Array.new

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


					uris=i.partition('href="')[2]
					uri=uris.partition('" target="_blank"')[0]
					if !uri.include? '&#xA;'
						url1 = URI.parse(uri)
						@req1 = Net::HTTP::Get.new(url1.path)
						@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}
						#@htmlofPage.push(@res1.body)

						@h1all=@res1.body.partition('<h3 class="recall-title-header">')[2]
						@titleofRecall=@h1all.partition('</h3>')[0]
						

				#	@HazardAll=@res1.body.partition('Hazard:</span>')[2]
				#	@HazardAfterPara=@HazardAll.partition('<p>')[2]
				#	@Hazard=@HazardAfterPara.partition('</p>')[0]

						@DescriptionAll=@res1.body.partition('<div class="recall-body">')[2]
						#@Description=@DescriptionAll.partition('FSIS and the company')[0]
					#@Description=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
						#@Description=@DescriptionAll

					if @DescriptionAll.include? '<p>FSIS and the company'
				 		@Description=@DescriptionAll.partition('<p>FSIS and the company')[0]
					elsif @DescriptionAll.include? "<p>FSIS has received no reports of"
						@Description=@DescriptionAll.partition('<p>FSIS has received no reports of')[0]
				#	elsif @DescriptionAll.include? '<p style="text-align: center">###'
				#			@Description=@DescriptionAll.partition('<p style="text-align: center">###')[0]
					end



					#@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)
						@RecallBasic3.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,,Description:'+@Description)

					@titleofRecall=@titleofRecall.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					@summary=@summary.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					#@Hazard =@Hazard.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')
					@Description=@Description.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '')

					Recall.create(:Category => "Meat and Poultry Products", :Details => @Description, :Summary => @summary, :Title => @titleofRecall)

					end
				end
			#end	
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
					#@times=@timeonsite.to_time
					if @date < @line
						@SummaryAll=i.partition(') ')[2]
						@summary=@SummaryAll.partition('</p>')[0]

						uris=i.partition('href="')[2]
						uri=uris.partition('" target="_blank"')[0]
						if !uri.include? '&#xA;'
							url1 = URI.parse(uri)
							@req1 = Net::HTTP::Get.new(url1.path)
							@res1 = Net::HTTP.start(url1.host, url1.port) {|http|  http.request(@req1)}
							#@htmlofPage.push(@res1.body)
							@h1all=@res1.body.partition('<h3 class="recall-title-header">')[2]
							@titleofRecall=@h1all.partition('</h3>')[0]

							#	@HazardAll=@res1.body.partition('Hazard:</span>')[2]
							#	@HazardAfterPara=@HazardAll.partition('<p>')[2]
							#	@Hazard=@HazardAfterPara.partition('</p>')[0]
							@DescriptionAll=@res1.body.partition('<div class="recall-body">')[2]
							#@Description=@DescriptionAll.partition('FSIS and the company')[0]
							#@Description=@res1.body.partition('FOR IMMEDIATE RELEASE</strong>')[2]
							#@Description=@DescriptionAll
							if @DescriptionAll.include? '<p>FSIS and the company'
								@Description=@DescriptionAll.partition('<p>FSIS and the company')[0]
							elsif @DescriptionAll.include? "<p>FSIS has received no reports of"
								@Description=@DescriptionAll.partition('<p>FSIS has received no reports of')[0]
							end

							#@RecallBasic1.push('title: '+ @titleofRecall+',,,, Summary: '+@summary+',,, Hazard: '+@Hazard+',,,Description:'+@Description)
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
	end
end