class MergerController < ApplicationController
  API_URL = 'https://api.pelotoncycle.com/quiz/next/'

  def merge_streams
    ret = { :message => 'Error: Missing stream param(s)' }.to_json
    
    stream1 = params[:stream1]
    stream2 = params[:stream2]
    
    unless stream1 and stream2
      render :json => ret
      return
    end

    render :json => { 
      :status => :ok, 
      :message => "Success!",
      :html => "<b>congrats</b>",
      :params => params
    }.to_json
  end
end
