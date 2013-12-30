--[[
BigReactor Version 1.0 Alpha
Do not modify, copy or distribute without permission of author
Helkarakse, 20131230
]]

-- Libraries
os.loadAPI("functions")

-- References
local functions = functions

-- Variables
local modem, port
local modemFrequency, maxStorage = 1000, 10000000

-- Functions

-- Loops/Handlers
local portLoop = function()
	while true do
		-- checks if the reactor is fully formed first
		if (port.getConnected()) then
			if (port.getEnergyStored() >= maxStorage) then
				if (port.getActive()) then
					-- reactor is full, turn off
					port.setActive(false)
					functions.info("Reactor storage is full, turning off the reactor.")
				end
			else
				if (port.getActive() == false) then
					port.setActive(true)
					functions.info("Reactor storage is not full, turning on the reactor.")
				end
			end
		end
		sleep(15)
	end
end

-- Init
local function init()
	local hasModem, modemDir = functions.locatePeripheral("modem")
	if (hasModem) then
		modem = peripheral.wrap(modemDir)
		modem.open(modemFrequency)
	else
		functions.error("No modem detected.")
		return
	end

	local hasPort, portDir = functions.locatePeripheral("BigReactors-Reactor")
	if (hasPort) then
		port = peripheral.wrap(portDir)
	else
		functions.error("No port detected.")
		return
	end

	parallel.waitForAll(portLoop)
end

init()