class SetDefaultForOptionValueAmount < ActiveRecord::Migration
  def self.up
    change_column :option_values, :amount, :decimal, :precision => 10, :scale => 2, :default => 0
  end

  def self.down
    change_column :option_values, :amount, :string
  end
end