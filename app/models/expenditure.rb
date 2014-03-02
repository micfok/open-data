class Expenditure < ActiveRecord::Base
	has_many :votes

	def refresh_votes
		upvotes = self.votes.where(direction: 1).count
		downvotes = self.votes.where(direction: -1).count
		self.update_attributes(upvotes: upvotes, downvotes: downvotes)
	end

	after_initialize :default_values

	def default_values
		self.upvotes = self.upvotes || 0
		self.downvotes = self.downvotes || 0
	end

end
