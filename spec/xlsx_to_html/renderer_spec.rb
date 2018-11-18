RSpec.describe XLSXToHTML::Renderer do
  let(:data) { build(:expected_data) }
  let(:renderer) { described_class.new(data) }
  let(:rendered_content) { fixture('rendered_content.txt') }

  describe '#render' do
    it { expect(renderer.render).to eq rendered_content }

    context 'when spreadsheet has no headers' do
      let(:data) { build(:without_headers_data) }
      let(:rendered_content) { fixture('without_headers_content.txt') }

      before do
        allow(renderer).to receive(:without_headers?).and_return(true)
      end

      it { expect(renderer.render).to eq rendered_content }
    end

    context 'when different templates are used' do
      let(:headers_content) { fixture('headers_rendered_content.txt') }
      let(:rows_content) { fixture('rows_rendered_content.txt') }

      before do
        allow(renderer).to receive(:common_template?).and_return(false)
      end

      it 'renders headers and rows separately' do
        described_class::ALLOWED_KEYS.each do |key|
          expect(renderer.render(key: key)).to eq public_send("#{key}_content")
        end
      end

      it 'raises ArgumentError when missing keyword "key"' do
        expect { renderer.render }.to raise_error ArgumentError
      end

      it 'raises ArgumentError when key is invalid' do
        expect { renderer.render(key: :invalid_key) }.
          to raise_error ArgumentError
      end

      it 'returns nil as headers when spreadsheet has no headers' do
        allow(renderer).to receive(:without_headers?).and_return(true)
        expect(renderer.render(key: :headers)).to be_nil
      end
    end
  end
end
