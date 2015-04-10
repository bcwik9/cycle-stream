class Stream < ActiveRecord::Base
  require 'net/http'
  
  API_URL = 'https://api.pelotoncycle.com/quiz/next/'
  
  validates_presence_of :stream1name, :stream2name
  
  after_create :update_stream1, :update_stream2

  def update_stream1
    response = Stream.get_api_response self.stream1name
    update_attributes!(:stream1value => response['current'].to_i)
  end

  def update_stream2
    response = Stream.get_api_response self.stream2name
    update_attributes!(:stream2value => response['current'].to_i)
  end

  def min
    [self.stream1value, self.stream2value].min
  end
  
  def update_min
    ret = {}
    if self.stream1value <= self.stream2value
      ret[:last] = self.stream1value
      update_stream1
    else
      ret[:last] = self.stream2value
      update_stream2
    end
    ret[:current] = min
    return ret
  end
  
  def self.get_api_response stream_name
    uri = URI.parse(API_URL + stream_name)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Get.new(uri.request_uri)
    
    JSON.parse(http.request(request).body)
  end
end
