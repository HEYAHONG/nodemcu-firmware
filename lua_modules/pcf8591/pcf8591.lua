local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] = M

id=0;

function M.init(addr,sda,scl)
i2c.setup(id, sda, scl, i2c.SLOW);
return addr;
end

function M.read(addr,con)
i2c.start(id);
i2c.address(id,addr, i2c.TRANSMITTER);
i2c.write(id,con);
i2c.stop(id);
i2c.start(id);
i2c.address(id,addr, i2c.RECEIVER);
c=i2c.read(id,1);
i2c.stop(id);
return string.byte(c);
end

function M.write(addr,con,val)
i2c.start(id);
i2c.address(id,addr, i2c.TRANSMITTER);
i2c.write(id,con);
i2c.write(id,val);
i2c.stop(id);
end