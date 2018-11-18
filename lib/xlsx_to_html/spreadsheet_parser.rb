module XLSXToHTML
  class SpreadsheetParser
    extend XLSXToHTML::Helpers

    def self.parse(xlsx_path, expected_headers = [])
      @xlsx_path = xlsx_path
      @headers = expected_headers

      { headers: headers, rows: rows }
    end

    class << self
      private

      def headers
        without_headers? ? [] : spreadsheet.row(headers_line)
      end

      def rows
        rows = []
        for_each_row(headers_line + 1) do |row|
          rows << row
        end
        rows.reject { |arr| arr.all?(&:nil?) }
      end

      def headers_line
        return spreadsheet.header_line if without_headers? ||
          !dynamic_headers_row? || dynamic_headers_row? && @headers.empty?

        for_each_row do |row, index|
          next unless row == @headers

          return index
        end

        raise XLSXToHTML::ExpectedDataNotFound, @headers
      end

      def for_each_row(start_row = nil)
        start_row = start_row.nil? ? spreadsheet.first_row : start_row
        (start_row..spreadsheet.last_row).each do |index|
          yield spreadsheet.row(index), index
        end
      end

      def spreadsheet
        Roo::Spreadsheet.open @xlsx_path
      end
    end
  end
end
