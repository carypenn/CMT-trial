class NpiService
  class << self
    def getNpiRecord(number)
      uri = URI("https://npiregistry.cms.hhs.gov/api/")
      params = { :version => 2.1, :number => number.to_s }
      uri.query = URI.encode_www_form(params)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri, {'Content-Type' => 'application/json'})
      response = http.request(request)
      body = JSON.parse(response.body)
      NpiRecord.build(body)
    end
  end
end
