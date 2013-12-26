--[[

	TickDump Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131210
	
]]

-- Libraries
os.loadAPI("functions")
os.loadAPI("json")

-- Variables
local fileName = "profile.txt"
local dimension = string.sub(os.getComputerLabel(), 1, 1)
local server = string.lower(string.sub(os.getComputerLabel(), 2))
local outputText, map = "", nil
local currentFileSize = 0
local uploadDelay = 30

local urlPush = "http://dev.otegamers.com/helkarakse/index.php?c=upload&m=put&server=" .. server .. "&type=" .. dimension

-- Functions
local uploadLoop = function()
	while true do
		-- only push the document if it changes
		if (fs.getSize(fileName) ~= currentFileSize) then
			-- check if the file exists
			if (fs.exists(fileName)) then
				-- file exists, store in outputText in preparation to send
				local file = fs.open(fileName, "r")
				outputText = file.readAll()
				file.close()
			end
			
			-- update the file size to the new one
			currentFileSize = fs.getSize(fileName)

			-- get the current array of players ingame
			local playerArray = map.getPlayerUsernames()
			
			local response = http.post(urlPush, "json=" .. textutils.urlEncode(outputText) .. "&players=" .. textutils.urlEncode(json.encode(playerArray)))
			if (response) then
				local responseText = response.readAll()
				functions.debug(responseText)
				response.close()
			else
				functions.debug("Warning: Failed to retrieve response from server")
			end
		end
		sleep(uploadDelay)
	end
end

local function init()
	local hasMap, mapDir = functions.locatePeripheral("adventure map interface")
	if (hasMap) then
		map = peripheral.wrap(mapDir)
		functions.debug("Map peripheral detected and wrapped.")
	else
		functions.debug("No map peripheral detected.")
		return;
	end

	if (fs.exists(fileName)) then
		parallel.waitForAll(uploadLoop)
	end
end

init()