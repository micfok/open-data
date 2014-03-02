class AddUpvotesAndDownvotesToExpenditures < ActiveRecord::Migration
  def change
    add_column :expenditures, :downvotes, :integer
    add_column :expenditures, :upvotes, :integer
  end
end
