local peripheral = peripheral
local redstone = redstone
local sleep = sleep

local sensor = peripheral.wrap("back")
	while true do
		local playerCount = #(sensor.getPlayerNames())
		if (playerCount > 0) then
			redstone.setBundledOutput("top", 0)
		else
			redstone.setBundledOutput("top", colors.orange)
		end
	sleep(1)
end