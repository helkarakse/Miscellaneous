local world, chest, map

local chestLoop = function()
	while true do
		sleep(5)
	end
end

local function init()
	map = peripheral.wrap("top")
	world = map.getWorld(0)
	chest = world.getTileEntity(884, 61, 959)
end

init()