
wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","密码")
while(wifi.sta.getip() ==nil)
do
end
print(wifi.sta.getip())

redis = dofile("redis.lua").connect('服务器ip',6379)

redis:subscribe("nodemcu", function(channel, msg)
print(channel, msg)
node.input(msg)
end) 
