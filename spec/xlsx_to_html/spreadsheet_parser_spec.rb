RSpec.describe XLSXToHTML::SpreadsheetParser do
  let(:spreadsheet) { fixture_path('with_dynamic_headers.xlsx') }

  context 'when dynamic_headers_row? is true' do
    let(:expected_data) { build(:expected_data) }

    before do
      allow(described_class).to receive(:dynamic_headers_row?).and_return(true)
    end

    it '.parse' do
      expect(described_class.parse(spreadsheet, expected_data[:headers])).
        to eq expected_data
    end

    it 'raises XLSXToHTML::ExpectedDataNotFound when headers was not found' do
      expect { described_class.parse(spreadsheet, %w[wrong wrong]) }.
        to raise_error XLSXToHTML::ExpectedDataNotFound
    end

    context 'when spreadsheet has a blank rows' do
      let(:spreadsheet) { fixture_path('with_empty_rows.xlsx') }

      it 'parses xlsx without empty rows' do
        expect(described_class.parse(spreadsheet, expected_data[:headers])).
          to eq expected_data
      end
    end
  end

  context 'when spreadsheet has no headers' do
    let(:spreadsheet) { fixture_path('without_headers.xlsx') }
    let(:expected_data) { build(:without_headers_data) }

    before do
      allow(described_class).to receive(:without_headers?).and_return(true)
    end

    it '.parse' do
      expect(described_class.parse(spreadsheet)).
        to eq expected_data
    end
  end
end
