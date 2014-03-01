class AddDirectionToVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :direction, :integer
  end
end
