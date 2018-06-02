require 'spec_helper'

class DummyEncrypter
  def self.encrypt(text)
    text
  end
end

class DummyEncoder
  def initialize(message, encripter)
    @message = message.strip
    @encripter = encripter || ObfuscationService
  end

  def encode
    @message
  end
end

describe EnigmaProcessor do
  describe '#encode' do
    let(:text) { "HELLO\nI AM IN TROUBLE" }
    let(:encoded_text) { '4|1|1A2|1A2|C\\n2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1' }
    let(:encoder) { DummyEncoder }
    let(:encrypter) { DummyEncrypter }
    let(:params) { {} }

    subject { described_class.new(text, params).encode }

    it { is_expected.to eq encoded_text }

    context 'with invalid content' do
      context 'when text not a string' do
        let(:text) { [1, 2, 3] }

        it { is_expected.to eq '' }
      end

      context 'with both valid and invalid content' do
        let(:text){ "-----[,1,2,3].\nGhost" }
        let(:encoded_text) { 'B2B|1D|B2B|2C|B2B|3B|1A1A1A\\nB1|4|C|3|A' }

        it { is_expected.to eq encoded_text }
      end

      context 'with an empty encrypter' do
        let(:text){ "-----[,1,2,3].\nGhost" }
        let(:encoded_text) { '--..--|.----|--..--|..---|--..--|...--|.-.-.-\\n--.|....|---|...|-' }
        let(:params) { { encripter: encrypter }}

        it { is_expected.to eq encoded_text }
      end

      context 'with an empty encoder and encrypter' do
        let(:text){ "-----[,1,2,3].\nGhost" }
        let(:encoded_text) { '-----[,1,2,3].\\nGhost' }
        let(:params) { { encoder: encoder, encripter: encrypter }}

        it { is_expected.to eq encoded_text }
      end
    end
  end
end
