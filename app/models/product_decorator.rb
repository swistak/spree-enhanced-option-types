Product.class_eval do
  attr_accessor :create_variants
  after_create :do_create_variants

  has_many :option_types, :through => :product_option_types, :order => "product_option_types.position ASC"

  def do_create_variants
    if create_variants == "1"
      generate_variant_combinations.each_with_index do |option_values, index|
        Variant.create({
            :product => self,
            :price => option_values.map(&:amount).sum + self.price,
            :option_values => option_values,
            :is_master => false,
            :sku => self.sku.blank? ? "#{self.name.to_url[0..3]}-#{index+1}" : "#{self.sku}-#{index+1}"
          })
      end
    end
  end

  def default_variant
    variants.first
  end

  def generate_variant_combinations(option_values = nil)
    option_values ||= self.option_types.map{|ot| ot.option_values}
    if option_values.length == 1
      option_values.first.map{|v| [v]}
    else
      result = []
      option_values.first.each do |value|
        result += generate_variant_combinations(option_values[1..-1]).map{|rv| rv.push(value) }
      end
      result
    end
  end
end