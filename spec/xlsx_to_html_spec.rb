RSpec.describe XLSXToHTML do
  let(:xlsx_path) { fixture_path('with_static_headers.xlsx') }

  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  it '.convert' do
    expect { described_class.convert(xlsx_path) }.not_to raise_error
  end
end
