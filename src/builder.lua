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
local io = io

-- Functions
local function getNextSlot()
	while turtle.getItemCount(currentSlot) < 1 do
		currentSlot = (currentSlot % 16) + 1
	end
	turtle.select(currentSlot)
end

local function checkInventoryEmpty()
	local empty = true
	for i = 1, 16 do
		if turtle.getItemCount(i) > 0 then
			empty = false
			break
		end
	end
	return empty
end

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

local function displayBlocked()
	print("Path is blocked. Please clear obstruction and press enter to continue.")
end

-- Functions (Movement)
local function moveForward(distance)
	for i = 1, distance do
		local success = turtle.forward()
		if (success == false) then
			displayBlocked()
			io.read()
		end
	end
end

local function moveBack(distance)
	for i = 1, distance do
		local success = turtle.back()
		if (success == false) then
			displayBlocked()
			io.read()
		end
	end
end

-- Functions (Placement)
local function placeForward(distance)
	for i = 1, distance do
		local success = turtle.forward()
		if (success == false) then
			displayBlocked()
			io.read()
		else
			
		end
	end
end

-- Functions (Building)
local function buildPillar()
	
end

local function init()
	if (#args == 0) then
		print("Missing argument: <program name> <distance>")
		return
	else
		distanceToTravel = tonumber(args[1])
	end
end

init()