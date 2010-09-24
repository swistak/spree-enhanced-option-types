Variant.class_eval do
  def self.by_option_value_ids(option_value_ids, product_id)
    Variant.find_by_sql(['
        SELECT
          option_values_variants.variant_id as id
        FROM
          option_values_variants, variants
        WHERE
          option_values_variants.option_value_id IN (?) 
            AND
          option_values_variants.variant_id = variants.id
            AND
          variants.product_id = ?
        GROUP BY
          option_values_variants.variant_id
        HAVING
          COUNT(option_values_variants.variant_id) = ?',
        option_value_ids, product_id, option_value_ids.length
      ]).map(&:reload)
  end

  after_create :copy_option_values
  def copy_option_values
    next if product.nil?
    variants = product.variants
    product.option_values = variants.map{|v| v.option_values}.flatten.uniq
    product.save!
  end
end