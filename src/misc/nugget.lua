local chest = peripheral.wrap("front")
local craft_slots = {2, 3, 5, 6, 7, 9, 10, 11}
while true do
    for i=1,16 do
        if turtle.getItemCount(i)>0 then
            turtle.select(i)
            while not turtle.drop() do
                sleep(120)
            end
        end
    end
    for i = 1, chest.getInventorySize() do
        local info = chest.getStackInSlot(i)
--        for k, v in pairs(info) do
--        print(k .. ":" .. v)
--        end
         if info then
            if (string.find(info["name"], "Nugget")) then
                if (info["qty"] > 9) then
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
                    turtle.drop()
                end
            end
        end
    end
    chest.condenseItems()
    sleep(1200)
end