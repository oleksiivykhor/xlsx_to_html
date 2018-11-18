module XLSXToHTML
  class Renderer
    include XLSXToHTML::Helpers

    ALLOWED_KEYS = %i[headers rows].freeze

    def initialize(data)
      @headers = data[:headers]
      @rows = data[:rows]
    end

    def render(key: nil)
      return if without_headers? && key.eql?(:headers) && !common_template?
      raise ArgumentError, 'missing keyword: key' if !common_template? && !key

      ERB.new(template_content(key), nil, '-').result(binding)
    end

    private

    def template_content(key = nil)
      template_path = template
      raise ArgumentError, "invalid key: #{key}" if !common_template? &&
        !ALLOWED_KEYS.include?(key)

      template_path = public_send("#{key}_template") unless common_template?
      File.read template_path
    end
  end
end
