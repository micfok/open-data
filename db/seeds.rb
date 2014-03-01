# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'spreadsheet'
Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open("#{Rails.root}/app/assets/files/fed.xls")
sheet = book.worksheet 0
category = []
category_names = []
category2 = []
sheet.each 1 do |row|
	if row[0]
		category << {:program => row[0], :amount => (row[2]/1000).floor}
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
		end
	end
	category2 << {:program => name, :amount => amount}
end
category2.sort! {|a,b| a[:amount] <=> b[:amount]}
category2.each do |expenditure|
	Expenditure.create(title:expenditure[:program], amount:expenditure[:amount].to_i)
end

#========================= 
#=======    TEST   =======
#=========================

@user = User.create(:device_id => 1231231)

(1..3).each do |id|
	Vote.create(user_id:1, expenditure_id:id, direction:1)
end




