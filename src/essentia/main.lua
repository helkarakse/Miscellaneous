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
local modemFrequency = 1
local rsSide = "right"

local modem

-- Rednet Configuration
local mfrCable = {
	{ aspect = "Ignis", color = colors.orange},
	{ aspect = "Aqua", color = colors.magenta},
	{ aspect = "Bestia", color = colors.white},
	{ aspect = "Arbor", color = colors.red},
	{ aspect = "Perfodio", color = colors.yellow}
}

local detectedAspects = {}

-- Functions
local function getCableColor(searchAspect)
	functions.debug("Searching the mfrCable array for the aspect: ", searchAspect)
	for key, value in pairs(mfrCable) do
		if (value.aspect == searchAspect) then
			return value.color
		end
	end

	return 0
end

local function activateRedstone(array)
	-- iterate through the array and add the colors needed for the output activation
	local sumColor = redstone.getBundledOutput(rsSide)
	functions.debug("Current redstone bundled output is: ", sumColor)
	for key, value in pairs(array) do
		local cableColor = getCableColor(value)
		functions.debug("Cable color found, returned as: ", cableColor)
		sumColor = sumColor + cableColor
	end
	redstone.setBundledOutput(rsSide, sumColor)
end

local modemHandler = function()
	while true do
		local _, side, freq, rfreq, message = os.pullEvent('modem_message')
		functions.debug("Message received from modem: ", message)
		local messageTable = textutils.unserialize(message)
		activateRedstone(messageTable)
	end
end

local function init()
	local hasModem, modemDir = functions.locatePeripheral("modem")
	if (hasModem) then
		modem = peripheral.wrap(modemDir)
		modem.open(modemFrequency)
	end

	-- reset the redstone outputs
	redstone.setBundledOutput(rsSide, 0)
	parallel.waitForAll(modemHandler)
end

init()