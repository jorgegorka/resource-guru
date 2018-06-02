#!/usr/bin/env ruby

require_relative '../enigma_processor'
require_relative '../morse_converter'
require_relative '../obfuscation_service'

begin
  file = File.open('./encrypted_message.txt', 'w')
  $stdin.each do |line|
    file.puts EnigmaProcessor.new(line).encode
  end
ensure
  p 'Your file with the encrypted content is ready. Thank you for encrypting with us and have a nice day.'
  file.close unless file.nil?
end
