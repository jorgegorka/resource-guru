require 'spec_helper'

describe ArrayUtils do
  describe '.flatten' do
    subject { described_class.flatten(array) }

    context 'with a non nested array' do
      let(:array) { [1, 4, 5, 'a', {}] }

      it { is_expected.to eq array }
    end

    context 'with a nested array' do
      let(:array) { [1, 4, ['1', [{ a: 'b' }], 'T', 3], 99, ['1']] }
      let(:flatten_array) { [1, 4, '1', { a: 'b' }, 'T', 3, 99, '1'] }

      it { is_expected.to eq flatten_array }
    end
  end
end
