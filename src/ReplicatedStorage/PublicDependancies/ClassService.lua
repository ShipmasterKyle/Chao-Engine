local service = {}

local items = require(game.ReplicatedStorage.MarketPlace.Class)
local rawItems = game.ReplicatedStorage.MarketPlace.rawItems

function service.GetArrayItem(array,item)
    for i,v in pairs(array) do
        if v.Name == item then
            return v
        else end
    return false
    end
end

--Clone and object and return it
function service:GetItem(item)
    local itemExist = service.GetArrayItem(items,item)
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
    local classExist = service.GetArrayItem(items,class)
    if classExist then
        local itemExist = service.GetArrayItem(items[class],item)
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
    local classExist = service.GetArrayItem(items,class)
    if classExist then
        return items[class]
    else
        return "Invalid Class"
    end
end

--Return an items stats (such as isDecor)
function service:GetItemDetails(class,item)
    local classExist = service.GetArrayItem(items,class)
    if classExist then
        local itemExist = service.GetArrayItem(items[class],item)
        if itemExist then
            return items[class][item]
        end
    else
        return "Invalid Class"
    end
end

--Returns the class an item belongs to.
function service:GetItemsClass(item)
    local class
    if service.GetArrayItem(items.Chao,item) then
        class = "Chao"
    elseif service.GetArrayItem(items.Food,item) then
        class = "Food"
    elseif service.GetArrayItem(items.Animals,item) then
        class = "Animals"
    elseif service.GetArrayItem(items.Toys) then
        class = "Toys"
    elseif service.GetArrayItem(items.Medals,item) then
        class = "Medals"
    else
        class = nil
    end
    return class
end

return service