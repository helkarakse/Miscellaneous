--[[

	TickDump Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131210
	
]]

os.loadAPI("functions")

local fileName = "profile.txt"
local dimension = string.sub(os.getComputerLabel(), 1, 1)
local outputText
local currentFileSize = 0
local uploadDelay = 30
local urlPush = "http://dev.otegamers.com/helkarakse/tps/upload.php?req=put&dim=" .. dimension

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
			
			local response = http.post(urlPush, "json=" .. textutils.urlEncode(outputText))
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
	if (fs.exists(fileName)) then
		parallel.waitForAll(uploadLoop)
	end
end

init()