require 'xlsx_to_html/version'
require 'roo'
require 'byebug'
require 'erb'

require 'xlsx_to_html/exceptions'
require 'xlsx_to_html/configuration'
require 'xlsx_to_html/helpers'
require 'xlsx_to_html/spreadsheet_parser'
require 'xlsx_to_html/renderer'

module XLSXToHTML
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.convert(xlsx_path, expected_headers = [], key: nil)
    data = XLSXToHTML::SpreadsheetParser.parse(xlsx_path, expected_headers)
    XLSXToHTML::Renderer.new(data).render(key: key)
  end
end
