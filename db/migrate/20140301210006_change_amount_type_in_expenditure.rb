class ChangeAmountTypeInExpenditure < ActiveRecord::Migration
	def up
		change_column :expenditures, :amount, :bigint
	end

	def down
		change_column :expenditures, :amount, :integer
	end
end
