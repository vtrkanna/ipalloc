class IpAllocPersistance

  def where(ip: nil, device_name: nil)
   f  = File.open("./store.txt").read
   r = f.scan(/,(#{ip}),([a-zA-Z0-9]*)/).flatten
   return {ip: r[0], device_name: r[1]}
  end

  def save(ip: '', device_name: '')
     File.open("./store.txt", "a"){|f| f << "1.2.0.0/16,#{ip},#{device_name} "}
     return {success: true}
  end

  def get_ip(ip: nil)
   f  = File.open("./store.txt").read
   r = f.scan(/,(#{ip})/).flatten
   return r
  end

  def get_device_name(device_name: nil)
    f  = File.open("./store.txt").read
    r = f.scan(/,(#{device_name})/).flatten
    return r
  end

end
