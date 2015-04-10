class MergerController < ApplicationController
  require 'net/http'

  API_URL = 'https://api.pelotoncycle.com/quiz/next/'

  def merge_streams
    ret = { :message => 'Error: Missing stream param(s)' }.to_json
    
    stream1 = params[:stream1]
    stream2 = params[:stream2]
    
    # ensure we have necessary params
    unless stream1 and stream2
      render :json => ret
      return
    end

    # get responses from api
    response1 = get_api_response stream1
    response2 = get_api_response stream2

    
    render :json => { 
      :status => :ok, 
      :message => "Success!",
      :html => "<b>congrats</b>",
      :params => params,
      :response1 => response1,
      :response2 => response2
    }.to_json
  end

  private
  
  def get_api_response stream_name
    uri = URI.parse(API_URL + stream_name)
    #args = {include_entities: 0, include_rts: 0, screen_name: 'johndoe', count: 2, trim_user: 1}
    #uri.query = URI.encode_www_form(args)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Get.new(uri.request_uri)
    
    response = http.request(request)
    JSON.parse response.body
  end
end
