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
		return false
	end
end

--Clone and object and return it
--TODO: Finish this. Bricks at line 41
function service:GetItem(item,class)
	if item == "Chao Drives" then
		local myDrives = {}
		for count = 1,10 do
			local rng = math.random(#driveData)
			table.insert(myDrives, driveData[rng])
			print(tostring(driveData[rng]))
		end
		for i,v in pairs(myDrives) do
			local item = service.GetArrayItem(items[class],v)
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
		local itemExist = service.GetArrayItem(items[class],item)
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
	elseif service.GetArrayItem(items.Animals.Animals,item) then
		class = "Animals"
	elseif service.GetArrayItem(items.Animals.Wisps,item) then
		class = "Wisps"
	elseif service.GetArrayItem(items.Animals.ChaoDrives,item) then
		class = "Drive"
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