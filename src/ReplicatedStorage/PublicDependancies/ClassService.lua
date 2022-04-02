local service = {}

local items = require(game.ReplicatedStorage.MarketPlace.Class)
local rawItems = game.ReplicatedStorage.MarketPlace.rawItems

--Clone and object and return it
function service:GetItem(item)
    local itemExist = table.find(items,item)
    if itemExist then
        if rawItems:FindFirstChild(item) then
            local myItem = rawItems[item]:Clone()
            return myItem
        end
    else
        return nil
    end
end

--Return the description of an item
function service:GetItemInfo(class,item)
    local classExist = table.find(items,class)
    if classExist then
        local itemExist = table.find(items[class],item)
        if itemExist then
            return items[class][item].Desc
        else
            return nil
        end
    else
        return "Invalid Class"
    end
end

--Return all members of a class
function service:GetChildrenOfClass(class)
    local classExist = table.find(items,class)
    if classExist then
        return items[class]
    else
        return "Invalid Class"
    end
end

--Return an items stats (such as isDecor)
function service:GetItemDetails(class,item)
    local classExist = table.find(items,class)
    if classExist then
        local itemExist = table.find(items[class],item)
        if itemExist then
            return items[class][item]
        end
    else
        return "Invalid Class"
    end
end

return service