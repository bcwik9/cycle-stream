class Stream < ActiveRecord::Base
  require 'net/http'
  
  API_URL = 'https://api.pelotoncycle.com/quiz/next/'
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  after_create :update_values

  def update_values
    uri = URI.parse(API_URL + self.name)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Get.new(uri.request_uri)
    
    response = JSON.parse(http.request(request).body)
    self.last = response[:last] = self.current
    self.current = response[:current].to_i
  end
  
end
