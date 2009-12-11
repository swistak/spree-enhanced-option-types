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