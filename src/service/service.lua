--[[

Player Services
Do not modify, copy or distribute without permission of author
Helkarakse 20131225

]]

-- Libraries
os.loadAPI("functions")

-- References
local functions = functions
local peripheral = peripheral

-- Variables
local map, command

-- Functions

-- Handlers

-- Events

-- Loops

-- Main
local function main()
	local hasMap, mapDir = functions.locatePeripheral("adventure map interface")
	if (hasMap) then
		map = peripheral.wrap(mapDir)
		functions.debug("Map peripheral detected and wrapped.")
	else
		functions.debug("No map peripheral detected. This is required.")
		return
	end

	-- Command blocks have no type for peripheral, will have to hard code direction
	command = peripheral.wrap("left")
	functions.debug("Command block detected and wrapped.")
end

main()