# A simple ruby rest client that uses the 'rest-client' gem
require 'rest-client'

# We could make the URL a configurable parameter in another file, read it as
# a command-line argument, or just hard-code it here for simplicity.
# Here I have my testing URL.
HOST = "http://localhost:3000/"
REQUEST_TYPE = :json # Use this to flip request type between :xml and :json.

# Treat any command line arguments as a single string.
organization_name = ARGV.join(" ")
#puts "DEBUG: #{organization_name.inspect}"

query = organization_name
if query == ""
  puts "Please enter an organization name to search for!"
end

puts RestClient.get 'http://localhost:3000/', {:params => {:search => query},
  :accept => REQUEST_TYPE}
