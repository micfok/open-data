class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	private
		def federal_spending
			Spreadsheet.client_encoding = 'UTF-8'
			book = Spreadsheet.open("#{Rails.root}/app/assets/files/fed.xls")
			sheet = book.worksheet 0
			category = []
			category_names = []
			category2 = []
			total = 0
			sheet.each 1 do |row|
				if row[1]
					category << {:program => row[0], :amount => row[2]}
					category_names << row[0]
					# puts row[1].to_s + " - " + row[3].to_s
				end
			end
			category_names = category_names.uniq
			category_names.each do |name|
				amount = 0
				category.each do |cat|
					if cat[:program] == name
						amount += cat[:amount]
						total += cat[:amount]
					end
				end
				category2 << {:program => name, :amount => amount}
			end
			category2.sort! {|a,b| a[:amount] <=> b[:amount]}
			return category2
			# @total = total			
		end

		def federal_total
			Spreadsheet.client_encoding = 'UTF-8'
			book = Spreadsheet.open("#{Rails.root}/app/assets/files/fed.xls")
			sheet = book.worksheet 0
			category = []
			category_names = []
			category2 = []
			total = 0
			sheet.each 1 do |row|
				if row[1]
					category << {:program => row[0], :amount => row[2]}
					category_names << row[0]
					# puts row[1].to_s + " - " + row[3].to_s
				end
			end
			category_names = category_names.uniq
			category_names.each do |name|
				amount = 0
				category.each do |cat|
					if cat[:program] == name
						amount += cat[:amount]
						total += cat[:amount]
					end
				end
				category2 << {:program => name, :amount => amount}
			end
			return total
			
		end


		helper_method :federal_spending, :federal_total
end
