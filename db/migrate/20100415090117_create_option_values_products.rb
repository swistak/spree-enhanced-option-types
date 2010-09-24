class CreateOptionValuesProducts < ActiveRecord::Migration
  def self.up
    create_table(:option_values_products, :id => false) do |t|
      t.column :product_id, :integer
      t.column :option_value_id, :integer
    end
    add_index :option_values_products, :product_id
    add_index :option_values_products, :option_value_id
  end

  def self.down
    drop_table(:option_values_products)
  end
end
