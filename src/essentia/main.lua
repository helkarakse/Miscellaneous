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
	{ aspect = "Perfodio", color = colors.yellow},
	{ aspect = "Terra", color = colors.green}
}

local masterAspects = {}

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

local function masterHasAspect(aspect)
	for key, value in pairs(masterAspects) do
		if (value.name == aspect) then
			return true
		end
	end

	return false
end

local function updateMasterQuantity(aspectName, aspectQuantity)
	for key, value in pairs(masterAspects) do
		if (value.name == aspectName) then
			value.quantity = aspectQuantity
		end
	end
end

-- Update the master table with the aspects from the modem messages
-- Untested, may be slow
local function updateMasterTable(inputTable)
	-- iterate through input table
	for key, value in pairs(inputTable) do 
		local aspectName = value.name
		local aspectQuantity = value.quantity

		-- check if the aspect already exists in the master table
		local exists = masterHasAspect(aspectName)
		if (exists) then
			-- already exists, update the quantity with the new quantity
			updateMasterQuantity(aspectName, aspectQuantity)
		else
			-- the aspect does not exist, add it to the master table
			table.insert(masterAspects, {name = aspectName, quantity = aspectQuantity})
		end
	end
end

local function getLowAspects()
	local lowAspects = {}
	for key, value in pairs(masterAspects) do
		if (value.quantity < 64) then
			table.insert(lowAspects, value.name)
		end
	end

	return lowAspects
end

local function activateRedstone(array)
	-- reset the bundled cable
	redstone.setBundledOutput(rsSide, 0)
	-- iterate through the array and add the colors needed for the output activation
	local sumColor = 0
	functions.debug("Current redstone bundled output is: ", sumColor)
	for key, value in pairs(array) do
		local cableColor = getCableColor(value)
		functions.debug("Cable color found, returned as: ", cableColor)
		sumColor = sumColor + cableColor
	end
	redstone.setBundledOutput(rsSide, sumColor)
end

local refreshLoop = function()
	while true do
		-- iterate through the master table and look for aspects that are not full
		local lowAspects = getLowAspects()
		-- functions.debug("The following aspects are low: ", textutils.serialize(lowAspects))
		-- iterate through lowAspects and enable the redstone outputs that are low
		activateRedstone(lowAspects)
		sleep(30)
	end
end

local modemHandler = function()
	while true do
		local _, side, freq, rfreq, message = os.pullEvent('modem_message')
		functions.debug("Message received from modem: ", message)
		local messageTable = textutils.unserialize(message)
		-- update the master aspect table with the updated quantities
		updateMasterTable(messageTable)
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
	parallel.waitForAll(modemHandler, refreshLoop)
end

init()