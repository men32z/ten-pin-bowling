require 'json'

# to use in the future maybe.
module Logging
  def log(message)
    msg = JSON.parse(File.read('./bin/language.json'))[message]
    puts msg || message.to_s
  rescue StandardError
    puts message.to_s
  end
end
