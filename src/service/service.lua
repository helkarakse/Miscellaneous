--[[

Player Services
Do not modify, copy or distribute without permission of author
Helkarakse 20131225

]]

-- Libraries
os.loadAPI("functions")
os.loadAPI("common")

-- References
local functions = functions
local switch = functions.switch
local common = common
local peripheral = peripheral
local os = os
local string = string

-- Variables
local map, command
local commandPrefix = "//"
local serviceArray = {
	{command = "/toggledownfall", cost = 3, keyword = "rain", description = "Turns rain on or off", announcement = " has toggled downfall in the overworld."},
}

-- Wrappers
-- send message wrapper
local function sendMessage(username, message)
	common.sendMessage(map, username, message)
end

-- Functions
-- returns an array of players in dimId
local function getPlayers(dimId)
	local returnArray = {}
	local players = map.getPlayerUsernames()
	for key, value in pairs(players) do
		local player = map.getPlayerByName(value)
		local playerEntity = player.asEntity()
		local playerDim = playerEntity.getWorldID()
		if (playerDim == tonumber(dimId)) then
			table.insert(returnArray, value)
		end
	end

	return returnArray
end

-- returns the id of a service keyword
local function getServiceId(keyword)
	local returnId = 0
	for i = 1, #serviceArray do
		if (serviceArray[i].keyword == keyword) then
			return i
		end
	end
end

-- runs a command then clears the block
local function runCommand(command)
	command.setCommand(command)
	command.runCommand()
	command.setCommand("")
end

local function makeAnnouncement(dimension, serviceId)
	-- only announce to players in overworld
	local playerArray = getPlayers(dimension)
	for key, value in pairs(playerArray) do
		sendMessage(value, value .. serviceArray[serviceId].announcement)
	end
end

-- Handlers
local function serviceHandler(username, message, args)
	local check = switch {
		["list"] = function()
			-- iterate through the service table and show the data
			for i = 1, #serviceArray do
				sendMessage(username, "//service buy " .. serviceArray[i].keyword .. " - " .. serviceArray[i].description .. " - $" .. serviceArray[i].cost)
			end
		end,
		["help"] = function()
			-- basic help
			sendMessage(username, "Usage: //service list")
		end,
		["buy"] = function()
			-- search through the service list and check to see if the keyword exists
			local id = getServiceId
			if (id > 0) then
				local serviceRow = serviceArray[id]
				runCommand(serviceRow.command)
				-- eco command goes here
				makeAnnouncement(0, id)
			else
				-- id did not exist, tell user
				sendMessage(username, "Usage: //service list")
			end
		end,
		default = function()
			-- respond that the command is not found
			sendMessage(username, "Usage: //service list")
		end,
	}

	check:case(args[2])
end

-- Events
local chatEvent = function()
	while true do
		local _, username, message = os.pullEvent("chat_message")
		-- check if the message is prefixed with a double // and that the user has the right auth level
		if (message ~= nil) then
			if (string.sub(message, 1, string.len(commandPrefix)) == commandPrefix) then
				-- strip the slash off the message and explode for args
				-- replace spaces with + (spaces are not working for some reason)
				local args = functions.explode("+", string.gsub(common.stripPrefix(message), " ", "+"))
				if (args[1] ~= "" and args[1] == "service") then
					serviceHandler(username, message, args)
				end
			end
		end
	end
end

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

	parallel.waitForAll(chatEvent)
end

main()