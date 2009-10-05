class OptionTypesPrototype < ActiveRecord::Base
  belongs_to :option_type
  belongs_to :prototype
end
