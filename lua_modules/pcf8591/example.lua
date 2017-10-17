wifi.setmode(wifi.SOFTAP)
cfg={}
cfg.ssid="nodemcu"
cfg.pwd="12345678"
wifi.ap.config(cfg)

M =  require("pcf8591");
M.init(0x48,2,1);
M.write(0x48,0x40,0xff);

led1 = 3
led2 = 4
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
 conn:on("receive", function(client,request)
 local buf = "";
 local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
 if(method == nil)then
 _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
 end
 local _GET = {}
 if (vars ~= nil)then
 for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
 _GET[k] = v
 end
 end
 A0  = string.format("<p>A0=%d </p>",adc.read(0))
 CH0  = string.format("<p>CH0=%d </p>",M.read(0x48,0x40))
 CH1  = string.format("<p>CH1=%d </p>",M.read(0x48,0x41))
 CH2  = string.format("<p>CH3=%d </p>",M.read(0x48,0x42))
 CH3  = string.format("<p>CH4=%d </p>",M.read(0x48,0x43))  
 buf = buf.."<head> <title>nodemcu</title><meta http-equiv=\"refresh\" content=\"5\"></head><body>"
 buf = buf.."<center> <h1> ESP8266 Web Control GPIO(D3,D4)</h1> </center>";
 buf = buf.."<p>D3:<a href=\"?pin1=ON\">ON</a> <a href=\"?pin1=OFF\">OFF</a></p>";
 buf = buf.."<p>D4:<a href=\"?pin2=ON\">ON</a> <a href=\"?pin2=OFF\">OFF</a></p>";
 buf = buf.."<p><form  method=\"get\">PRF OUT:<input type=\"text\" name=\"out\" /><input type=\"submit\" value=\"Submit\" /></form></p>"
 buf = buf..A0..CH0..CH1..CH2..CH3
 buf = buf.."</body>"
 local _on,_off = "",""
 if(_GET.pin1 == "ON")then
 gpio.write(led1, gpio.LOW);
 elseif(_GET.pin1 == "OFF")then
 gpio.write(led1, gpio.HIGH);
 elseif(_GET.pin2 == "ON")then
 gpio.write(led2, gpio.LOW);
 elseif(_GET.pin2 == "OFF")then
 gpio.write(led2, gpio.HIGH);
 end
 if(_GET.out ~= nil )then 
 M.write(0x48,0x40,tonumber(_GET.out));
 end
 client:send(buf);
 client:close();
 collectgarbage();
 end)
 end)


