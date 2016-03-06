require 'active_model'
require './lib/ip_alloc_persistance'
require 'ipaddr'
require 'pry'
class IpAlloc
  include ActiveModel::Validations
  attr_accessor :ip_block, :ip, :device_name

  validates :ip, presence: true
  #validates :device_name, presence: true, format: { with: /\A[a-zA-Z]+\z/,  message: "Enter valid device name" }, on: :save
  validate :ip_addr_range_validation
  #validate :ip_uniqueness_check, on: :where

  def ip_addr_range_validation
   errors.add(:ip, "check valid ip") unless (IPAddr.new "1.2.0.0/16").include?(self.ip) 
  end

  def ip_uniqueness_check
     i = IpAllocPersistance.new
     r = i.get_ip(ip: self.ip)
    errors.add(:ip, "Ip Addr alredy exist") unless r.blank?
  end

  def where(ip: nil, device_name: nil)
    i = IpAllocPersistance.new
    i.where(ip: ip, device_name: device_name)
  end

  def save(ip: nil, device_name: nil)
    i = IpAllocPersistance.new
    i.save(ip: ip, device_name: device_name)
  end
  
end
