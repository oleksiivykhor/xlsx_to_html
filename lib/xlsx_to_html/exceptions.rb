module XLSXToHTML
  class ExpectedDataNotFound < StandardError
    def initialize(data = nil)
      @data = data
    end

    def message
      msg = 'Expected data was not found'
      msg ? "#{msg}: #{@data}" : msg
    end
  end
end
