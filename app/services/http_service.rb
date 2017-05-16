require 'net/http'
require 'uri'

class HttpService

  def self.get(uri, *options)
    response = Net::HTTP.get(URI(uri))
    JSON.parse(response)
  end

end