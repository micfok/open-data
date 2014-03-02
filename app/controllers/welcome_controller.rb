class WelcomeController < ApplicationController
	require 'spreadsheet'
	skip_before_filter  :verify_authenticity_token

	def index
		# @x = federal_spending()
		@x = Expenditure.all
		z = 0
		@x.each do |y| z += y.amount  end
		@total = z
		# puts @x.to_json
	end

	def vote
		if params[:device_id]
			device_id = params[:device_id]
			user = User.where(device_id: device_id).first
			if !user
				user = User.create(device_id: device_id)
			end
			user.votes.destroy_all

			#UPVOTES
			votes = params[:votes]
			votes.each do |k,v|
				if v != 0
					user.votes.create(direction: v, expenditure_id: k)
					expenditure = Expenditure.find(k)
					if expenditure
						expenditure.refresh_votes
					end
				end

			end

			render :json => user.to_json
			# upvotes = params[:upvotes]
			# upvotes.each do |upvote_id|
			# 	user.votes.create(direction: 1, expenditure_id: upvote_id)
			# end

			# #DOWNVOTES
			# downvotes = params[:downvotes]
			# downvotes.each do |downvote_id|
			# 	user.votes.create(direction: 2, expenditure_id: downvote_id)
			# end

		end
	end

	def community
		@expenditures = Expenditure.all
		return_value = []
		@expenditures.each do |exp|
			return_value << {id: exp.id, 
								title: exp.title, 
								amount: exp.amount,
								upvotes: exp.upvotes.to_s, 
								downvotes: exp.downvotes.to_s, 
								score: (exp.upvotes - exp.downvotes).to_s}
		end
		# return_value.sort!(&:score)
		# @users.sort! { |a,b| a.login_count <=> b.login_count }
		return_value = return_value.sort_by! { |u| -u[:score].to_i}
		render :json => return_value.to_json
	end

end
