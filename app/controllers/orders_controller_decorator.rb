OrdersController.class_eval do
  # This is hack to get extension working with both edge and 0.9.x series
  unless private_instance_methods.include?("create_before")
    create.before :create_before
    create.after.clear
  end

  def create_before
    variant = nil; quantity = nil;
    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Array)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Array)
      variant = Variant.find(variant_id)
    end if params[:products]
    
    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      variant = Variant.find(variant_id)
    end if params[:variants]

    params[:option_values].each_pair do |product_id, otov|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Array)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Array)
      option_value_ids = otov.map{|option_type_id, option_value_id| option_value_id}
      variant = Variant.by_option_value_ids(option_value_ids, product_id).first
    end if params[:option_values]

    if quantity > 0 && variant
      if quantity > variant.on_hand
        flash[:error] = t(:stock_to_small) % [variant.on_hand]
      else
        @order.add_variant(variant, quantity)
        if @order.save
          # store order token in the session
          session[:order_token] = @order.token
        else
          flash[:error] = t(:out_of_stock)
        end
      end
    elsif quantity > 0
      flash[:error] = t(:wrong_combination)
    else
      flash[:error] = t(:wrong_quantity)
    end
  end

  # override the default r_c behavior (remove flash - redirect to edit details instead of show)
  create.wants.html do
    if flash[:error].blank?
      redirect_to edit_order_url(@order)
    else
      redirect_to :back
    end
  end
end
