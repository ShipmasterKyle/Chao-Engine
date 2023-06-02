local service = {}

local items = require(game.ReplicatedStorage.MarketPlace.Class)
local rawItems = game.ReplicatedStorage.MarketPlace.rawItems

--Define chao drive names for future reference
local driveData = {
	"RunDrive",
	"SwimDrive",
	"PowerDrive",
	"FlyDrive"
}

function service.GetArrayItem(array,item)
	for i,v in pairs(array) do
		if v.Name == item then
			return v
		else end
	end
	return false
end

--Clone and object and return it
--TODO: Finish this. Bricks at line 41
function service:GetItem(item)
	if item == "Chao Drives" then
		local myDrives = {}
		for count = 1,10 do
			local rng = math.random(#driveData)
			table.insert(myDrives, driveData[rng])
			print(tostring(driveData[rng]))
		end
		for i,v in pairs(myDrives) do
			local item = service.GetArrayItem(items,v)
			if item then
				local myItem = rawItems[v]:Clone()
				return myItem
			else
				print(v)
				print(myDrives)
				warn("Something is wrong on our part.")
				return
			end
		end
	else
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
end

--Return the description of an item
function service:GetItemInfo(item)
		local itemExist = service.GetArrayItem(items,item)
		if itemExist then
			return items[item].Desc
		else
			return nil
		end
end

--Return all members of a class
function service:GetChildrenOfClass(class)
	local children = {}
	for i,v in pairs(items) do
		if v.Class == class then
			table.insert(v)
		end
	end
	return children
end

--Return an items stats (such as isDecor)
function service:GetItemDetails(item)
	local itemExist = service.GetArrayItem(items,item)
	if itemExist then
		return items[item]
	end
end

--Returns the class an item belongs to.
function service:GetItemsClass(item)
	local valve = service.GetArrayItem(items,item)
	if valve then
		return valve.Class
	end
	return "Item's Class Not Found"
end

return service