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
local maximumStorage = 10000000
local modemFrequency, cutoffThreshold = 1000, 0.75

-- Functions

-- Loops/Handlers
local portLoop = function()
	while true do
		-- checks if the reactor is fully formed first
		if (port.getConnected()) then
			local storedEnergy = port.getEnergyStored()
			if (storedEnergy >= (cutoffThreshold * maximumStorage)) then
				if (port.getActive()) then
					-- reactor is full, turn off
					port.setActive(false)
					functions.info("Reactor deactivated")
				end
			else
				if (port.getActive() == false) then
					port.setActive(true)
					functions.info("Reactor activated")
				end
			end

			-- transmit update packet over modem
			local reactorStatus = ""
			if (port.getActive() == true) then
				reactorStatus = "ACTIVE"
			else
				reactorStatus = "INACTIVE"
			end

			local packet = {
				power = storedEnergy,
				status = reactorStatus,
				rods = port.getNumberOfControlRods(),
				temperature = port.getTemperature(),
				fuel = ((port.getFuelAmount() / port.getFuelAmountMax()) * 100),
				controlLevel = port.getControlRodLevel(),
				rate = port.getEnergyProducedLastTick()
			}

			modem.transmit(modemFrequency, 1001, textutils.serialize(packet))
		end
		sleep(5)
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
