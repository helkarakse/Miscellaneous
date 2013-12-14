local chest = peripheral.wrap("front")
local craft_slots = {2, 3, 5, 6, 7, 9, 10, 11}
while true do
    for i=1, 16 do
        if turtle.getItemCount(i)>0 then
            turtle.select(i)
            turtle.drop()
        end
    end
    
    for i = 1, chest.getInventorySize() do
		local info = chest.getStackInSlot(i)
		print("Slot number is now: " .. i)
		if (info ~= nil and (string.find(info["name"], "Nugget")) and info["qty"] > 9) then
			turtle.select(1)
			print("push item into slot")
			turtle.suck()
			local no = turtle.getItemCount(1)
			for j, k in ipairs(craft_slots) do
			    turtle.transferTo(k, no/9)
			end
			turtle.craft()
			-- Drop the ingots into the chest
			turtle.select(2)
			turtle.turnRight()
			turtle.drop()
			turtle.turnLeft()
			-- Drop the leftover nuggets back into the chest
		    turtle.select(1)
		    turtle.drop()
		end
	    chest.condenseItems()
    end
    sleep(1200)
end