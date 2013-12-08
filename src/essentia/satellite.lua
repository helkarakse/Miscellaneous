--[[

	Essentia Satellite Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131209
]]

-- Libraries
os.loadAPI("functions")

-- Variables
local jarType = "tilejar"
local jars = {}

local modem
local modemFrequency = 1

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
		-- check if any of the jars are not full, ie, not filled with 64 of the aspect
		for key, value in pairs(jars) do
			local aspects = value.getAspects()
			local quantity = aspects[1].quantity
			
			if (quantity < 64) then
--				functions.debug("Less than 64 essentia detected in jar of type: ", aspects[1].name)
				table.insert(arrayPacket, aspects[1].name)
			end
		end
		
		-- check if the arrayPacket array has entries
		if (functions.getTableCount(arrayPacket) > 0) then
			functions.debug("Transmitting modem message containing aspects which are not full")
			modem.transmit(modemFrequency, modemFrequency, textutils.serialize(arrayPacket))
			-- clear the array packet for next check
			arrayPacket = {}
		end
		sleep(60)
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