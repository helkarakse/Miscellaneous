--[[

	Essentia Satellite Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131209
]]

-- Libraries
os.loadAPI("functions")

-- Variables
local peripheralType = "tilejar"
local modem
local jars = {}

local refreshLoop = function()

end

local modemHandler = function()
	
end

local function init()
	local hasModem, modemDir = functions.locatePeripheral("modem")
end

init()