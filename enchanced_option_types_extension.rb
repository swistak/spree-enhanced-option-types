# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class EnchancedOptionTypesExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/enchanced_option_types"

  # Please use enchanced_option_types/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    base = File.dirname(__FILE__)
    Dir.glob(File.join(base, "app/**/*_decorator.rb")){|c| load(c)}

    # make your helper avaliable in all views
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
  end
end
