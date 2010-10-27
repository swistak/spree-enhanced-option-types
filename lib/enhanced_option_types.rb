require 'spree_core'
require 'enhanced_option_types_hooks'

module EnhancedOptionTypes
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      # Activation logic goes here.  A good use for this is performing class_eval on classes that are defined
      # outside of the extension (so that monkey patches are not lost on subsequent requests in development mode.)
      lambda{
        Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
          Rails.env == "production" ? require(c) : load(c)
        end

        Spree::BaseController.class_eval do
          helper VariantSelection
        end

        Numeric.class_eval do
          def sign_symbol
            if self > 0
              "+"
            elsif self < 0
              "-"
            else
              ""
            end
          end
        end

        Admin::PrototypesController.class_eval do
          before_filter :load_sortable

          def load_sortable
            render_to_string :partial => 'sortable_header'
          end
        end

      }
    end

    config.to_prepare &self.activate
  end
end