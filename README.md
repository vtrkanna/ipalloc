# ipalloc

**IMP**
- Response as json
- retrive data , access alocated ip
- API documentation in plain text


**Validations:**
- Device name formate [a-zA-Z0-9]. Device name validation for insert device.
- All address apart from this range is invalid [1.2.0.0, 1.2.255.255]
- Each address can be assigned to a single device
- IPv4 address validation
- Attempt to assign an address that has already been assigned to a device should result in error.

**Optional:**

**1. Send ip and retrive device name.**

  request: { :ip => "1.2.1.1"}

  Response: { :ip => "1.2.1.1", :device_name => "kanna" }
  /
  { :success => true/false :ip => "1.2.1.1", :device_name => "kanna", :messages => [:error=>{}] }


**1. Send ip and device name to associate ip to the device**

  Request: { :ip => '', :device_name => ''}

  Response: { :ip => '', :device_name => '' }


**Persistance**

  1.2.0.0/16,1.2.3.4,device1 1.2.0.0/16,1.2.3.5,device2 1.2.0.0/16,1.2.3.6,device3

**cidr calculation**

  ddr3 = IPAddr.new "192.168.2.0/24"

  ddr3.include?("192.168.2.1")

  (IPAddr.new "192.168.2.0/24").include?("192.168.2.0")  => true 

**Input**:

  **To Store device :**
    curl -d "ip=1.2.1.1&device_name=kanna" http://localhost:9292/api/insert_device
    
  **To Get Device :**
    curl http://localhost:9292/api/get_device?ip=1.2.1.1


**Start App:**
   **rackup**
   
Used Gems
  * sinatra
  * activemodel
  * pry
   
