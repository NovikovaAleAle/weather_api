class RestDbApi

  def initialize(url)
    @url = url
    @headers = {
      params: {apikey: ENV['API_KEY']}
    }
  end

  def call
    res = RestClient.get(@url, @headers)
    body = JSON.parse(res)
  end
end