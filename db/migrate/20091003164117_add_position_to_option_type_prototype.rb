class AddPositionToOptionTypePrototype < ActiveRecord::Migration
  def self.up
    add_column :option_types_prototypes, :position, :integer, :default => 1
  end

  def self.down
    remove_column :option_types_prototypes, :position
  end
end