// This little gem finds if there is a possible combination
// that begining matches values. returns tru if there's at least one match.
//
// WARNING this method has equivalent on ruby side (possible_combinations? helper)
// If you plan to change it, make sure they both behave in the same way
function possible_combination(values){
  var any_match = false;
  jQuery.each(ov_combinations, function(i, combination){
    var result = true
    jQuery.each(values, function(i, v){
      result = result && (combination[i] == v)
    })
    any_match = any_match || result;
  })
  return(any_match);
}

// Callback called each time variant is changed.
function variant_changed(variant_id) {
  var va = variant_attributes[variant_id];
  var new_price = va.price;
  if($('.price.update')[0]) {
    new_price = $('.price.update').text().replace(/[\d,.-]+/, new_price.toFixed(2));
    $('.price.update').text(new_price);
  }
  if($('span.on-hand')[0]) {
    $('span.on-hand').text(va.on_hand);
  }
  update_variant_images(variant_id, va.description);
}

$('#product-variants table.t2d input[type=radio]').bind("change", function(){
  variant_changed(ov_to_variant[this.value]);
})

// This binds event watching function to every radio box
$("#product-variants input[type=radio].option-value").bind("change", function(){
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

  variant_changed(ov_to_variant[selected_values]);
});

$('#product-variants select.option-type').bind("change", function(){
  var selected_values = [];
  // for each option group (represented by select)
  $("#product-variants select.option-type").map(function(i, select){
    // for each option value
    $(select).find("option").each(function(i, option){
      var ov_value = option.value.replace(/\D+/, '');
      // check if there's at least one possible combination for this setting
      var can_be_set = possible_combination(selected_values.concat([ov_value]));
      $(option).attr('disabled', !can_be_set)
      if (!can_be_set) // uncheck if it can't be used'
        $(option).attr('selected', false);
    })

    // find radio that is checked, or can be checked
    var selected_option = $(select).find("option:selected");
    if (!selected_option[0])
      selected_option = $(select).find("option:selected").attr('selected', true)
    // this should be absolutelly always possible, but just to be sure
    if (selected_option[0])
      selected_values.push(selected_option.attr('value').replace(/\D+/, ''))
  })

  variant_changed(ov_to_variant[selected_values]);
})