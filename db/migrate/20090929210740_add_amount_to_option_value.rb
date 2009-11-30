class AddAmountToOptionValue < ActiveRecord::Migration
  def self.up
    add_column :option_values, :amount, :decimal
  end

  def self.down
    remove_column :option_values, :amount
  end
end