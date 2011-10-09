require "net/http"

class ChatsController < ApplicationController
  def room
    redirect_to login_path unless session[:username]
  end
  
  def new_message
    faye = URI.parse 'http://localhost:9292/faye'
    message = {:username => session[:username], :msg => params[:message]}.to_json
    Net::HTTP.post_form(faye, :message => {:channel => '/messages/public', :data => message}.to_json)
    
    respond_to do |f|
      f.js
    end
  end
end
