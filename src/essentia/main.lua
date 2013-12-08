--[[

	Essentia Main Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131209
]]

-- Libraries
os.loadAPI("functions")

-- Variables
local jarType = "tilejar"
local mfrRednetType = "factoryredstonecable"
local modem
local modemFrequency = 1

-- Functions
local modemHandler = function()
	while true do
		local _, side, freq, rfreq, message = os.pullEvent('modem_message')
		functions.debug("Message received from modem: ", message)
		local array = textutils.unserialize(message)
		for key, value in pairs(array) do
			functions.debug(value)
		end
	end
end

local function init()
	local hasModem, modemDir = functions.locatePeripheral("modem")
	if (hasModem) then
		modem = peripheral.wrap(modemDir)
		modem.open(modemFrequency)
	end
	
	parallel.waitForAll(modemHandler)
end

init()