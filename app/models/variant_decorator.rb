Variant.class_eval do
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

  def master_variant
    Variant.find(:first, :conditions => {:is_master => true, :product_id => self.product_id})
  end

  # Ensures a new variant takes the product master price when price is not supplied
  def check_price
    if self.price.blank?
      raise "Must supply price for variant or master.price for product." if self == master_variant
      self.price = self.option_values.map(&:amount).sum + master_variant.price
    end
  end
end