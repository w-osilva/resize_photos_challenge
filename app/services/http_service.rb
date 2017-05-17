require 'net/http'
require 'tempfile'
require 'uri'

class HttpService

  def self.get(uri, **options)
    response = Net::HTTP.get(URI(uri))
    JSON.parse(response)
  end


  def self.get_to_tempfile(url)
    ext = File.extname url
    uri = URI.parse url

    Net::HTTP.start(uri.host, uri.port) do |http|
      response = http.get(uri.path)
      file = Tempfile.new(['', ext])
      file.binmode
      file.write(response.body)
      file.flush
      file
    end
  end

end