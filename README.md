# XLSXToHTML

Xlsx to html converting

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xlsx_to_html'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xlsx_to_html

## Usage

```ruby
require 'xlsx_to_html'

XLSXToHTML.convert('path/to/xlsx')
```

Or

```ruby
require 'xlsx_to_html'

XLSXToHTML.convert('path/to/xlsx', ['Expected', 'Headers'], key: :headers)
```

Specify key (`:headers` or `:rows`) when you use different templates for headers and rows

## Configuration

```ruby
XLSXToHTML.configure do |config|
  config.template = 'path/to/template'
end
```

Or

```ruby
configuration = XLSXToHTML.configuration
configuration.template = 'path/to/template'
```

### Configuration options

| Option                |   Expected value   |     Default value       |      Notes                                                                  |
| --------------------- |:------------------:|:-----------------------:| ---------------------------------------------------------------------------:|
| `template`            | `path/to/template` | `default/template/path` |                                                                             |
| `headers_template`    | `path/to/template` | `defautl/template/path` | Use with `common_template` `false`                                          |
| `rows_template`       | `path/to/template` | `defautl/template/path` | Use with `common_template` `false`                                          |
| `common_template`     | `true`, `false`    |   `true`                |                                                                             |
| `without_headers`     | `true`, `false`    |   `false`               | Use when spreadsheet has no headers                                         |
| `dynamic_headers_row` | `true`, `false`    |   `false`               | When headers are present not on the first line. Use with `expected_headers` |

## Templates

Use template markup as below

For common template
```ruby
<table>
  <thead>
    <tr>
      <%- @headers.each do |header| -%>
        <th><%= header %></th>
      <%- end -%>
    </tr>
  </thead>
  <tbody>
    <%- @rows.each do |row| -%>
      <tr>
        <%- row.each do |cell| -%>
          <td><%= cell %></td>
        <%- end -%>
      </tr>
    <%- end -%>
  </tbody>
</table>
```

For headers template
```ruby
<thead>
  <tr>
    <%- @headers.each do |header| -%>
      <th><%= header %></th>
    <%- end -%>
  </tr>
</thead>
```

For rows template
```ruby
<tbody>
  <%- @rows.each do |row| -%>
    <tr>
      <%- row.each do |cell| -%>
        <td><%= cell %></td>
      <%- end -%>
    </tr>
  <%- end -%>
</tbody>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/oleksiivykhor/xlsx_to_html

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
