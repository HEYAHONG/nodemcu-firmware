
 pcf8591模块说明
==== 
PCF8591为一个基于I2C总线的8位AD/DA转换器，可用于玩具等。 <br />
文件简介： <br />
pcf8591.lua: <br />
pcf8591模块，需要在固件中集成i2c模块。 <br />
init(七位地址，sda引脚，scl引脚)；//引脚与GPIO模块相同 <br />
write(七位地址，控制寄存器内容，DA转换器输出值) <br />
read(七位地址,控制寄存器内容) <br />
example.lua: <br />
一个包含pcf8591.lua的示例，需要固件中集成GPIO,ADC模块。成功运行后会出现一个名为nodemcu的热点，密码为12345678  <br />
![烧写示例]1.jpg <br />
![网页效果]2.jpg

