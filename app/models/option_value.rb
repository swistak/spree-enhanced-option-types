class OptionValue < ActiveRecord::Base
  belongs_to :option_type
  acts_as_list :scope => :option_type
  has_and_belongs_to_many :variants
  has_and_belongs_to_many :products
  has_many :option_values_products
end
