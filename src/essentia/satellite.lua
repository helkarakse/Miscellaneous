--[[

	Essentia Satellite Version 1.0 Alpha
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131209
]]

-- Libraries
os.loadAPI("functions")

-- Variables
local jarType = "tt_aspectContainer"
local jars = {}

local modem
local modemFrequency = 1

-- User settings
local refreshDelay = 30

-- Functions
local function initJars()
	for _, side in pairs(peripheral.getNames()) do
		if (peripheral.getType(side) == jarType) then
			local jarPeripheral = peripheral.wrap(side)
			table.insert(jars, jarPeripheral)
		end
	end
	
	functions.debug("Jars detected: ", #jars)
end

local refreshLoop = function()
	local arrayPacket = {}
	while true do
		-- build packet for transmission
		for key, value in pairs(jars) do
			table.insert(arrayPacket, {name = value.getAspects(), quantity = value.getAspectCount(value.getAspects())})
		end
		
		modem.transmit(modemFrequency, modemFrequency, textutils.serialize(arrayPacket))
		-- clear the array packet
		arrayPacket = {}
		sleep(refreshDelay)
	end
end

local function init()
	local hasModem, modemDir = functions.locatePeripheral("modem")
	if (hasModem) then
		modem = peripheral.wrap(modemDir)
		modem.open(modemFrequency)
	end
	
	initJars()
	parallel.waitForAll(refreshLoop)
end

init()