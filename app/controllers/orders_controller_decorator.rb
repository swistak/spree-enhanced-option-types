OrdersController.class_eval do
  create.after do
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
      variant = Variant.by_option_value_ids(option_value_ids).first
    end if params[:option_values]

    if quantity > 0 && variant
      @order.add_variant(variant, quantity)
      @order.save
      # store order token in the session
      session[:order_token] = @order.token
    elsif quantity > 0
      flash[:error] = "We're sorry but you can't select this combination of options."
    else
      flash[:error] = "You have to choose quantity larger then 0"
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
