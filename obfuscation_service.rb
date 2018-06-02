# Substitute a morse character with:
#
# A number that represents the amount of consecutive dot characters .... = 4
# A letter that represents the position in the alphabet of the amount of consecutive dashes ---- d
class ObfuscationService
  ASCII_UPPERCASE_LETTERS = 64
  MORSE_DOT_CHARACTER = '.'.freeze

  class << self
    def encrypt(message)
      return unless message

      message.gsub(/(\.+)|(\-+)/).map do |matched_string|
        matched_string[0] == MORSE_DOT_CHARACTER ? transform_dots(matched_string) : transform_dashses(matched_string)
      end.join('')
    end

    private

    def transform_dots(string)
      string.length
    end

    def transform_dashses(string)
      (ASCII_UPPERCASE_LETTERS + string.length).chr
    end
  end
end
