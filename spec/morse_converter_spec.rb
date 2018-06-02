require 'spec_helper'

class DummyEncrypter
  def self.encrypt(string)
    string
  end
end

describe MorseConverter do
  let(:encryptor) {}

  describe '#encrypt' do
    subject { described_class.new(string_message, encryptor).encrypt }

    context 'with default encryption' do
      context 'when message is a sentence' do
        let(:string_message) { 'Cylons detected 123' }
        let(:encrypted_message) { 'A1A1|A1B|1A2|C|A1|3/A2|1|A|1|A1A1|A|1|A2/1D|2C|3B' }

        it { is_expected.to eq encrypted_message }

        it 'should separate words with /' do
          expect(subject.count('/')).to eq 2
        end
      end

      context 'when message has not allowed characters' do
        let(:string_message) { 'Cyloñs detected?' }
        let(:encrypted_message) { 'A1A1|A1B|1A2|C|3/A2|1|A|1|A1A1|A|1|A2' }

        it 'should ignore invalid characters' do
          expect(subject).to eq encrypted_message
        end

        context 'when invalid characters are removed' do
          let(:string_message) { 'Cylos detected' }

          it 'should produce same result as the one with invalid characters' do
            expect(subject).to eq encrypted_message
          end
        end
      end

      context 'when message is a word' do
        let(:string_message) { 'Cylons' }
        let(:encrypted_message) { 'A1A1|A1B|1A2|C|A1|3' }

        it { is_expected.to eq encrypted_message }

        it 'should separate characters with |' do
          expect(subject.count('|')).to eq 5
        end
      end

      context 'when message is a single character' do
        let(:string_message) { '.' }
        let(:encrypted_message) { '1A1A1A' }

        it { is_expected.to eq encrypted_message }
      end
    end

    context 'with no encryption' do
      let(:encryptor) { DummyEncrypter }

      context 'when message is a sentence' do
        let(:string_message) { 'Cylons detected 123' }
        let(:morse_message) { '-.-.|-.--|.-..|---|-.|.../-..|.|-|.|-.-.|-|.|-../.----|..---|...--' }

        it { is_expected.to eq morse_message }

        it 'should separate words with /' do
          expect(subject.count('/')).to eq 2
        end
      end

      context 'when message has not allowed characters' do
        let(:string_message) { 'Cyloñs detected?' }
        let(:encrypted_message) { '-.-.|-.--|.-..|---|.../-..|.|-|.|-.-.|-|.|-..' }

        it 'should ignore invalid characters' do
          expect(subject).to eq encrypted_message
        end

        context 'when invalid characters are removed' do
          let(:string_message) { 'Cylos detected' }

          it 'should produce same result as the one with invalid characters' do
            expect(subject).to eq encrypted_message
          end
        end
      end

      context 'when message is a word' do
        let(:string_message) { 'Cylons' }
        let(:morse_message) { '-.-.|-.--|.-..|---|-.|...' }

        it { is_expected.to eq morse_message }

        it 'should separate characters with |' do
          expect(subject.count('|')).to eq 5
        end
      end

      context 'when message is a single character' do
        let(:string_message) { '.' }
        let(:morse_message) { '.-.-.-' }

        it { is_expected.to eq morse_message }
      end
    end
  end
end
