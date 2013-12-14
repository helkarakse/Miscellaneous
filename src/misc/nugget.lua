local chest = peripheral.wrap("front")
local craft_slots = {2, 3, 5, 6, 7, 9, 10, 11}
-- the temp nugget storage chest
local interimChestSize = 54

local function dumpExtras()
	print("Dumping extra nuggets")
	turtle.turnLeft()
	turtle.select(1)
	turtle.drop()
	turtle.turnRight()
end

local function dumpIngots(ingotSlot)
	print("Dumping ingots")
	turtle.select(ingotSlot)
	turtle.turnRight()
	turtle.drop()
	turtle.turnLeft()
end

while true do
	print("Clearing inventory...")
    for i= 1, 16 do
        if turtle.getItemCount(i)>0 then
            turtle.select(i)
            turtle.drop()
        end
    end
    
    print("Starting nugget crafting process")
    for slotNumber = 1, chest.getInventorySize() do
		local info = chest.getStackInSlot(slotNumber)
		if (info ~= nil and (string.find(info["name"], "Nugget")) and info["qty"] > 9) then
			turtle.select(1)
			print("Getting items...")
			turtle.suck()
			
			local ingotSlot = 1
			-- if the nuggets are divisible by 9 properly, then the ingot slot will be in 1
			local itemCount = turtle.getItemCount(1)
			if ((itemCount % 9) == 0) then 
				ingotSlot = 1
			else
				ingotSlot = 2
			end
			
			-- dividing the items
			print("Splitting up the items for crafting")
			for j, k in ipairs(craft_slots) do
			    turtle.transferTo(k, itemCount/9)
			end
			
			print("Crafting the item")
			turtle.craft()
			-- Drop the ingots into the chest
			dumpIngots(ingotSlot)
			-- Drop the leftover nuggets into another chest
		    dumpExtras()
		end
    end
    -- condense the stacks and pull from iron chest into wood chest
    print("Stacks condensed")
    chest.condenseItems()
    print("Triggering the transfer of nuggets to main chest")
	redstone.setOutput("top", true)
	sleep(5)
	redstone.setOutput("top", false)
	print("Waiting...")
    sleep(60)
end