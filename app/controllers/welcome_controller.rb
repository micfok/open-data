class WelcomeController < ApplicationController
require 'spreadsheet'

def index
	# @x = federal_spending()
	@x = Expenditure.all
	z = 0
	@x.each do |y| z += y.amount  end
	@total = z
	# puts @x.to_json
end

end
