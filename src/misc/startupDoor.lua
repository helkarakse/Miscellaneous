--[[
 
    MacroStartup Version 1.1 Beta
    Do not modify, copy or distribute without permission of author
	Helkarakse, 20130614
 	
 	Changelog:
 	- 1.1 - Changed the startup code to pull latest copy from github instead of private server, 20131202
]]--

-- File array of github links
local fileArray = {
	{link = "https://raw.github.com/helkarakse/Miscellaneous/master/src/misc/oteDoor.lua", file = "door"},
}

-- This filename is the file that will be executed
local indexFile = "door"

-- Set to true to overwrite files
local overwrite = true
 
-- Helper function to pull latest file from server
local function getProgram(link, filename)
	print("Downloading '" .. filename .. "' file from server.")
	
	-- remove the file if override is true
	if (overwrite == true) then
		shell.run("rm " .. filename)
	end
	
	-- get the latest copy
	local data = http.get(link)
	if data then
    	print("File '" .. filename .. "' download complete.")
		local file = fs.open(filename,"w")
		file.write(data.readAll())
		file.close()
	end
end
 
-- download and start program
for i = 1, #fileArray do
	getProgram(fileArray[i].link, fileArray[i].file)
end

shell.run(indexFile)