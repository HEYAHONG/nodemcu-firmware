
wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","ÃÜÂë")
while(wifi.sta.getip() ==nil)
do
end
print(wifi.sta.getip())

redis = dofile("redis.lua").connect('·şÎñÆ÷ip',6379)

redis:subscribe("nodemcu", function(channel, msg)
print(channel, msg)
node.input(msg)
end) 
