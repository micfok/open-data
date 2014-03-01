class WelcomeController < ApplicationController
require 'spreadsheet'

def index
	@x = federal_spending()
	@total = federal_total()
	puts @x.to_json
end

end
