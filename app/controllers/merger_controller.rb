class MergerController < ApplicationController

  def merge_streams
    ret = { :message => 'Error: Missing stream param(s)' }.to_json
    
    stream1_name = params[:stream1]
    stream2_name = params[:stream2]
    
    # ensure we have necessary params
    unless stream1_name and stream2_name
      render :json => ret
      return
    end

    # look up streams, or create new ones
    stream1 = Stream.where('name = ?', stream1_name).first
    if stream1.nil?
      stream1 = Stream.create!(name: stream1_name)
    end

    stream2 = Stream.where('name = ?', stream2_name).first
    if stream2.nil?
      stream2 = Stream.create!(name: stream2_name)
    end

    # stream will have a last value of nil if it was just created
    # and we dont need to poll for an updated value
    if stream1.last.nil? or stream2.last.nil?
      ret = {
        
      }
    end

    
    render :json => { 
      :status => :ok, 
      :message => "Success!",
      :html => "<b>congrats</b>",
      :params => params,
      :response1 => response1,
      :response2 => response2
    }.to_json
  end

end
