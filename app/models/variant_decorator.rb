Variant.class_eval do
  after_update :adjust_variant_prices, :if => lambda{|r| r.price_changed? && r.is_master}

  def self.by_option_value_ids(option_value_ids)
    Variant.find_by_sql(['
        SELECT
          option_values_variants.variant_id as id,
          COUNT(option_values_variants.variant_id) as count
        FROM
          option_values_variants
        WHERE
          option_values_variants.option_value_id IN (?)
        GROUP BY
          option_values_variants.variant_id
        HAVING
          count = ?',
        option_value_ids, option_value_ids.length
      ]).map(&:reload)
  end

  def calculate_price(master_price=nil)
    price = (master_price || product.master.price).to_i
    price+= self.option_values.map{|ov| ov.amount.to_i}.sum
    price > 0 ? price : 0
  end

  # Ensures a new variant takes the product master price when price is not supplied
  def check_price
    if self.price.blank?
      raise "Must supply price for variant or master.price for product." if self.is_master
      self.price = calculate_price
    end
  end

  def adjust_variant_prices
    product.variants.each{|v| v.update_attribute(:price, v.calculate_price(self.price))}
  end
end