module XLSXToHTML
  class Configuration
    attr_accessor :template, :headers_template, :rows_template

    BOOLEAN_METHODS = %i[common_template without_headers
                         dynamic_headers_row].freeze

    def initialize
      @template = get_template_path('default')
      @headers_template = get_template_path('default_headers')
      @rows_template = get_template_path('default_rows')
      @common_template = true
      @without_headers = false
      @dynamic_headers_row = false
    end

    BOOLEAN_METHODS.each do |method_name|
      attr_writer method_name

      define_method "#{method_name}?" do
        instance_variable_get "@#{method_name}"
      end
    end

    private

    def get_template_path(template)
      File.expand_path("../templates/#{template}.html.erb", __FILE__)
    end
  end
end
