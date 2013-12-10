--[[

	Rail Pillar Builder (Turtle) Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse 20131211
	
]]

-- Variables
local args = {...}
local distanceToTravel = 0

local fuelSlot = 16
local currentSlot = 1

-- References
local tonumber = tonumber

-- Refuel by checking fuel levels then 
local function doRefuel() 
	-- check if there is fuel first
	if (turtle.getItemCount(fuelSlot) > 0) then
		turtle.select(fuelSlot)
		turtle.refuel(1)
		turtle.select(currentSlot)
		return true
	else
		return false
	end
end

-- Check if a refuel is needed
local function needRefuel()
	if turtle.getFuelLevel() < 200 then
		return true;
	else
		return false;
	end
end

-- Functions (Building)

local function init()
	if (#args == 0) then
		print("Missing argument: <program name> <distance>")
		return
	else
		distanceToTravel = tonumber(args[1])
	end
end

init()