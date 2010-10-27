class Prototype < ActiveRecord::Base
  has_and_belongs_to_many :properties
  has_and_belongs_to_many :option_types, :order => "option_types_prototypes.position ASC"
  has_many :option_types_prototypes
  validates_presence_of :name
end