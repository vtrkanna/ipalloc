require 'sinatra'
require './models/ip_alloc.rb'
require './lib/ip_alloc_persistance'
require 'json'
require 'pry'
class App < Sinatra::Base
#include IpAlloc

  get '/api/get_device' do
    #puts params[:ip]
    #puts params[:device_name]
    i = IpAlloc.new
    i.ip = params[:ip]
    i.device_name = params[:device_name]
    #puts i.valid?
    if i.valid?
      i.where(ip: params[:ip], device_name: params[:device_name]).to_json
    else
      puts i.errors.messages
      i.errors.messages.to_json
    end
  end

  post '/api/insert_device' do
    puts params
    i = IpAlloc.new
    i.ip = params[:ip]
    i.device_name = params[:device_name]
    iap = IpAllocPersistance.new
    r  = iap.get_ip(ip: i.ip)
    d = iap.get_device_name(device_name: params[:device_name])
    if i.valid?
      if r.blank? && d.blank?
        i.save(ip: params[:ip], device_name: params[:device_name]).to_json
      else
        message = {:ip => ["Ip Addr / Device  aleady exist"]}
        message.to_json
      end
    else
      i.errors.messages.to_json
    end
  end

end
