# Receives a text and encodes it using provided encoder and encrypter
# If our encryption service is compromised it's very easy to replace either encoder and/or encrypter
class EnigmaProcessor
  attr_reader :text, :encoded_text

  def initialize(text, options = {})
    @text = text
    @encoder = options.fetch(:encoder, MorseConverter)
    @encripter = options.fetch(:encripter, ObfuscationService)
  end

  def encode
    return '' unless text.is_a? String

    text.each_line.map do |line|
      @encoder.new(line, @encripter).encrypt
    end.join('\n')
  end
end
