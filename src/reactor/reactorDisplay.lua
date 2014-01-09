--[[
BigReactor Monitor Version 1.0 Alpha
Do not modify, copy or distribute without permission of author
Helkarakse, 20131230
]]

-- Libraries
os.loadAPI("functions")

-- References
local functions = functions

-- Variables
local modem, monitor
local modemFrequency = 1000

-- Functions
local function updateMonitor(packet)
	monitor.clear()
	monitor.setCursorPos(3, 3)
	monitor.write("Reactor Status: " .. packet.temperature .. "'C [" .. packet.status .. "]")
	monitor.setCursorPos(3, 5)
	monitor.write("Reactor Energy: " .. packet.power .. " RF @ " .. packet.rate .. " RF/t")
	monitor.setCursorPos(3, 7)
	monitor.write("Reactor Control Rods: " .. packet.rods .. " @ " .. packet.controlLevel .. "%")
	monitor.setCursorPos(3, 9)
	monitor.write("Fuel %: " .. packet.fuel)
end

-- Loops/Handlers
local modemLoop = function()
	while true do
		local _, side, freq, rfreq, message = os.pullEvent('modem_message')
		if (freq == modemFrequency) then
			functions.debug("Message received from modem: ", message)
			updateMonitor(textutils.unserialize(message))
		end
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

	local hasMonitor, monitorDir = functions.locatePeripheral("monitor")
	if (hasMonitor) then
		monitor = peripheral.wrap(monitorDir)
	else
		functions.error("No monitor detected.")
		return
	end

	parallel.waitForAll(modemLoop)
end

init()