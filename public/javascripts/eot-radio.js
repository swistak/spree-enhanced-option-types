// This binds event watching function to every radio box
$("#product-variants input[type=radio]").bind("change", function(){
  // this callback is actually called twice, one for radio box that's selected
  // second one for unselected, so we choose one and run with it.
  if(!this.checked) return;

  var selected_values = [];
  // for each option group (represented by fieldset)
  $("#product-variants fieldset").map(function(i, fieldset){
    // for each option value
    $(fieldset).find("input[type=radio]").each(function(i, radio){
      var ov_value = radio.id.replace(/\D+/, '');
      // check if there's at least one possible combination for this setting
      var can_be_set = possible_combination(selected_values.concat([ov_value]));
      $(radio).attr('disabled', !can_be_set)
      if (!can_be_set) // uncheck if it can't be used'
        $(radio).attr('checked', false);
    })

    // find radio that is checked, or can be checked
    var checked_radio = $(fieldset).find("input:checked");
    if (!checked_radio[0])
      checked_radio = $(fieldset).find("input:enabled").attr('checked', true)
    // this should be absolutelly always possible, but just to be sure
    if (checked_radio[0])
      selected_values.push(checked_radio.attr('id').replace(/\D+/, ''))
  })

  var new_price = parseFloat($('.original_price .price').text().replace(/[^\d,.]/g, ''))
  $('#product-variants input:checked ~ .modifier').each(function(i, el){
    var modifier = parseFloat($(el).text().replace(/[^\d,.-]/g, ''))
    new_price = new_price + modifier
  })
  new_price = $('.modified_price .price').text().replace(/[\d,.-]+/, new_price.toFixed(2))
  $('.modified_price .price').text(new_price)
});