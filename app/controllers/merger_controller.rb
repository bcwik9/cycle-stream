class MergerController < ApplicationController

  def merge_streams
    ret = { :message => 'Error: Missing stream param(s)' }
    
    stream1_name = params[:stream1]
    stream2_name = params[:stream2]
    
    # ensure we have necessary params
    unless stream1_name and stream2_name
      render :json => ret.to_json
      return
    end

    # look up streams, or create new ones
    stream = Stream.where('stream1name = ? AND stream2name = ?', stream1_name, stream2_name).first
    if stream.nil?
      just_created = true
      stream = Stream.create!(stream1name: stream1_name, stream2name: stream2_name)
    end

    # if stream was just created, we don't have to update values
    if just_created
      ret = {
        :last => nil,
        :current => stream.min
      }
    else
      # grab new value for lowest stream
      ret = stream.update_min
    end
    
    render :json => ret.to_json
  end

end
