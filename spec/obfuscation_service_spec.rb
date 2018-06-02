require 'spec_helper'

describe ObfuscationService do
  describe '.encrypt' do
    subject { described_class.encrypt(morse_character) }

    context 'should encrypt consecutive dots into a number' do
      let(:morse_character) { '...' }
      let(:encoded_response) { '3' }

      it { is_expected.to eq encoded_response }
    end

    context 'should encrypt consecutive dashses into a letter' do
      let(:morse_character) { '----' }
      let(:encoded_response) { 'D' }

      it { is_expected.to eq encoded_response }
    end

    context 'should encrypt mixed dots and dashses' do
      let(:morse_character) { '...--.---...-' }
      let(:encoded_response) { '3B1C3A' }

      it { is_expected.to eq encoded_response }
    end

    context 'should ignore other characters' do
      let(:morse_character) { '...sass--.b---...dfds-' }
      let(:encoded_response) { '3B1C3A' }

      it { is_expected.to eq encoded_response }
    end

    context 'should ignore invalid data' do
      let(:morse_character) {}

      it { is_expected.to be_nil }
    end
  end
end
