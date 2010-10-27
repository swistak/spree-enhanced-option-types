OrdersController.class_eval do

  def populate
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      if !params[:quantity].is_a?(Hash)
        quantity = params[:quantity].to_i
      else
        quantity = params[:quantity][variant_id].to_i
      end
      @order.add_variant(Variant.find(variant_id), quantity) if quantity > 0
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      @order.add_variant(Variant.find(variant_id), quantity) if quantity > 0
    end if params[:variants]

    params[:option_values].each_pair do |product_id, otov|
      if !params[:quantity].is_a?(Array)
        quantity = params[:quantity].to_i
      else
        quantity = params[:quantity][variant_id].to_i
      end
      option_value_ids = otov.map{|option_type_id, option_value_id| option_value_id}
      variant = Variant.by_option_value_ids(option_value_ids, product_id).first
      @order.add_variant(variant, quantity) if quantity > 0
    end if params[:option_values]

    redirect_to cart_path

    #    if quantity > 0 && variant
    #      if quantity > variant.on_hand
    #        flash[:error] = t(:stock_to_small) % [variant.on_hand]
    #      else
    #        @order.add_variant(variant, quantity)
    #        if @order.save
    #          # store order token in the session
    #          session[:order_token] = @order.token
    #        else
    #          flash[:error] = t(:out_of_stock)
    #        end
    #      end
    #    elsif quantity > 0
    #      flash[:error] = t(:wrong_combination)
    #    else
    #      flash[:error] = t(:wrong_quantity)
    #    end
    #    if flash[:error].blank?
    #      # redirect_to edit_order_url(@order)
    #      redirect_to cart_path
    #    else
    #      redirect_to :back
    #    end
  end

end
