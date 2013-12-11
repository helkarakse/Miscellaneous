--[[

	Rail Pillar Builder (Turtle) Version 0.1 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse 20131211
	
]]

-- Variables
local args = {...}
local distanceToTravel = 0
local repeats = 1

local fuelSlot = 16
local currentSlot = 1

-- References
local tonumber = tonumber
local io = io

-- Functions
local function checkInventoryEmpty()
	local empty = true
	for i = 1, 15 do
		if turtle.getItemCount(i) > 0 then
			empty = false
			break
		end
	end
	return empty
end

local function getNextSlot()
	while (checkInventoryEmpty() == false) do
		print("More materials are required to complete the task.")
		print("Refill my inventory and press enter to continue.")
		io.read()
		currentSlot = 1
	end
		
	while turtle.getItemCount(currentSlot) < 1 do
		currentSlot = (currentSlot % 15) + 1
	end
	
	turtle.select(currentSlot)
end

-- Refuel by checking fuel levels
local function doRefuel() 
	-- check if there is fuel first
	if (turtle.getItemCount(fuelSlot) > 0) then
		turtle.select(fuelSlot)
		turtle.refuel(1)
		turtle.select(currentSlot)
	else
		while (turtle.getItemCount(fuelSlot) == 0) do
			print("Turtle is out of consumable fuel items. Place fuel in slot: " .. fuelSlot)
			print("Press enter to continue.")
			io.read()
		end
		
		turtle.select(fuelSlot)
		turtle.refuel(1)
		turtle.select(currentSlot)
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
		if (needRefuel()) then
			doRefuel()
		end
		
		local success = false
		
		while not success do
			success = turtle.forward()
			if not success then
				displayBlocked()
				io.read()
			end
		end
	end
end

local function moveBack(distance)
	for i = 1, distance do
		if (needRefuel()) then
			doRefuel()
		end
		
		local success = false
		
		while not success do
			success = turtle.back()
			if not success then
				displayBlocked()
				io.read()
			end
		end
	end
end

local function moveUp()
	if (needRefuel()) then
		doRefuel()
	end
	
	local success = false
		
	while not success do
		success = turtle.up()
		if not success then
			displayBlocked()
			io.read()
		end
	end
end

local function moveDown()
	if (needRefuel()) then
		doRefuel()
	end
	
	local success = false
		
	while not success do
		success = turtle.down()
		if not success then
			displayBlocked()
			io.read()
		end
	end
end

local function turnLeft()
	if (needRefuel()) then
		doRefuel()
	end
	
	local success = false
		
	while not success do
		success = turtle.turnLeft()
		if not success then
			displayBlocked()
			io.read()
		end
	end
end

local function turnRight()
	if (needRefuel()) then
		doRefuel()
	end
	
	local success = false
		
	while not success do
		success = turtle.turnRight()
		if not success then
			displayBlocked()
			io.read()
		end
	end
end

-- Functions (Placement)
local function placeForward(distance)
	for i = 1, distance do
		if (needRefuel()) then
			doRefuel()
		end
		
		local success = false
		
		while not success do
			success = turtle.forward()
			if not success then
				displayBlocked()
				io.read()
			end
		end
	end
end

local function placeBlock()
	getNextSlot()
	turtle.placeDown()
end

-- Functions (Building)
local function buildPillarCapLayer()
	moveUp()
	moveUp()
	moveForward(4)
	turnLeft()
	moveBack(4)
	
	for i = 1, 4 do
		placeBlock()
		placeForward(8)
		turnLeft()
		moveForward(1)
		turnLeft()
		placeBlock()
		placeForward(8)
		turnRight()
		moveForward(1)
		turnRight()
	end
	
	placeBlock()
	placeForward(8)
	moveBack(4)
	turnRight()
	moveForward(4)
end

local function buildPillarLayer()
	-- move up by one block to place below
	moveUp()
	moveForward(4)
	placeBlock()
	turnLeft()
	placeForward(2)
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	placeBlock()
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	turnLeft()
	placeBlock()
	placeForward(4)
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	placeBlock()
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	turnLeft()
	placeBlock()
	placeForward(4)
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	placeBlock()
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	turnLeft()
	placeBlock()
	placeForward(4)
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	placeBlock()
	turnLeft()
	moveForward(1)
	turnRight()
	moveForward(1)
	turnLeft()
	placeBlock()
	moveForward(1)
	placeBlock()
	moveForward(1)
	turnRight()
	moveBack(4)
	moveDown()
end

local function init()
	if (#args < 2) then
		print("Missing arguments: <program name> <repeats> <distance>")
		return
	else
		repeats = tonumber(args[1])
		distanceToTravel = tonumber(args[2])
	end
	
	if (repeats >= 1 and distanceToTravel > 0) then
		for i = 1, repeats do
			buildPillarLayer()
			buildPillarCapLayer()
			moveForward(distanceToTravel + 1)
			moveDown()
			moveDown()
		end
	else
		print("Invalid parameters were provided. Terminating...")
		return
	end
end

init()