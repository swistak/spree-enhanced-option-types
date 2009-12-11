module VariantSelection
  # Returns array of arrays of ids of option values,
  # that represent all possible combinations of option _values
  # sorted by option type position in that product.
  # 
  def options_values_combinations(product)
    product.variants.map{|v| # we get all variants from product
      # then we take all option_values
      v.option_values.sort_by{|ov|
        # then sort them by position of option value in product
        ProductOptionType.find(:first, :conditions => {
            :option_type_id => ov.option_type_id,
            :product_id => product.id
          }).position
      }.map(&:id) # and get the id
    }
  end

  # Returns hash that maps _array of ids of option values_ to _variant attributes_,
  #
  # eg.
  #
  # { [1,2,3,4] => <Variant#1> }
  #
  def ov_to_variant_map(product)
    result = {}
    product.variants.map{|v|
      # we get all variants from product
      # then we take all option_values
      key = v.option_values.sort_by{|ov|
        # then sort them by position of option value in product
        ProductOptionType.find(:first, :conditions => {
            :option_type_id => ov.option_type_id,
            :product_id => product.id
          }).position
      }.map(&:id)
      result[key] = v
    }
    return(result)
  end

  # checks if there's a possible combination
  #
  # WARNING! This helper has equivalent on javascript side.
  # If you plan to change it, make sure they both behave in the same way
  def possible_combination?(all_combinations, values)
    all_combinations.any?{|combination|
      values.enum_for(:each_with_index).all?{|v, i| combination[i] == v}
    }
  end
end
