Admin::PrototypesController.class_eval do
  skip_after_filter :set_habtm_associations

  reorder_option_types = lambda do
    set_habtm_associations
    @prototype.option_types_prototypes.each do |otp|
      new_position = params[:option_type][:id].index(otp.option_type_id.to_s)
      # Rails get crazy when table doesn't have PrimaryID,
      # updates don't work, so we have to do them using update_all
      OptionTypesPrototype.update_all({ # SET
          :position => new_position
        }, { #WHERE
          :prototype_id => otp.prototype_id,
          :option_type_id => otp.option_type_id
        })
    end
  end
  
  update.after(&reorder_option_types)
  create.after(&reorder_option_types)
end