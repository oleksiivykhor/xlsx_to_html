module XLSXToHTML
  module Helpers
    # For accessing configuration methods directly
    def method_missing(method_name, *args)
      super unless XLSXToHTML.configuration.respond_to? method_name

      XLSXToHTML.configuration.public_send(method_name)
    end

    def respond_to_missing?(method_name, include_private = false)
      XLSXToHTML.configuration.respond_to?(method_name) || super
    end
  end
end
