--[[

	Rail Pillar Builder (Turtle) Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse 20131211
	
]]

local args = {...}
local distanceToTravel = 0

local function init()
	if (#args <= 1) then
		print("Missing argument: <program name> <distance>")
		return
	end
end

init()