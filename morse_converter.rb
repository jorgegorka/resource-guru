# Converts a text to morse code
class MorseConverter
  ALPHABET_TO_MORSE_CODE = Hash[
    'A' => '.-',
    'B' => '-...',
    'C' => '-.-.',
    'D' => '-..',
    'E' => '.',
    'F' => '..-.',
    'G' => '--.',
    'H' => '....',
    'I' => '..',
    'J' => '.---',
    'K' => '-.-',
    'L' => '.-..',
    'M' => '--',
    'N' => '-.',
    'O' => '---',
    'P' => '.--.',
    'Q' => '--.-',
    'R' => '.-.',
    'S' => '...',
    'T' => '-',
    'U' => '..-',
    'V' => '...-',
    'W' => '.--',
    'X' => '-..-',
    'Y' => '-.--',
    'Z' => '--..',
    '1' => '.----',
    '2' => '..---',
    '3' => '...--',
    '4' => '....-',
    '5' => '.....',
    '6' => '-....',
    '7' => '--...',
    '8' => '---..',
    '9' => '----.',
    '0' => '-----',
    '.' => '.-.-.-',
    ',' => '--..--'
  ].freeze

  CHARACTER_SEPARATOR = '|'.freeze
  WORD_SEPARATOR = '/'.freeze

  attr_reader :message

  def initialize(message, encripter)
    @message = message.strip
    @encripter = encripter || ObfuscationService
  end

  def encrypt
    message.upcase.split(' ').map do |word|
      word_to_morse(word)
    end.join(WORD_SEPARATOR)
  end

  private

  def word_to_morse(word)
    word.chars.map do |character|
      character_to_morse(character)
    end.compact.join(CHARACTER_SEPARATOR)
  end

  def character_to_morse(character)
    @encripter.encrypt(ALPHABET_TO_MORSE_CODE[character])
  end
end
