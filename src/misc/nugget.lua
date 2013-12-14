local chest = peripheral.wrap("front")
local slot_number = chest.getInventorySize()
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
    for i = 1, (slot_number-1) do
        local info = chest.getStackInSlot(i)
        for k, v in pairs(info) do
        print(k .. ":" .. v)
        end
         if info then
            if not string.find(info["name"], "Ingot") then
                if info["qty"]>9 then
                    chest.pushItemIntoSlot("right", i, math.floor(info["qty"]/9)*9, 0)
                    turtle.select(1)
                    local no = turtle.getItemCount(1)
                    for j, k in ipairs(craft_slots) do
                        turtle.transferTo(k, no/9)
                    end
                    turtle.craft()
                    while not turtle.drop() do
                        sleep(120)
                    end
                end
            end
        end
    end
    chest.condenseItems()
    sleep(1200)
end