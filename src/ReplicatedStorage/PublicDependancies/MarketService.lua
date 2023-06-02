--[[
	MaketService
	Handles the Chao Black Market
]]

local service = {}

local wait = task.wait
local market = require(game.ReplicatedStorage.MarketPlace.MarketData)
local class = require(game.ReplicatedStorage.PublicDependancies.ClassService)

function service.GetArrayItem(array,item)
	for i,v in pairs(array) do
		if v.Name == item then
			return v
		else end
	end
	return false
end

--Initialize the system
function service:Initialize(plr)
	warn("This system is experimental. It does not save any data at all. Make sure you use everything as you will lose it upon leaving the game.")
	if workspace:FindFirstChild(tostring(plr.Name.." Inventory")) then
		warn("This player's data already exist. Overwriting with a new folder...")
		workspace[plr.Name.." Inventory"]:Destroy()
	else
		print("Writing new folder for player")
	end
	local folder = Instance.new("Folder", workspace)
	folder.Name = tostring(plr.Name.." Inventory")
end

--loop through the marketplace and add all for sale items to the ui
function service:LoadMarket(frame,template)
	if frame and template then
		for i,v in pairs(market) do
			if v.forSale == true then
				local copy = template:Clone()
				copy.Name = v.Name
				copy.NameBox.Text = v.Name
				copy.Desc.Value = v.desc
				-- TODO: Use UI Service to make a viewport frame.
				copy.Parent = frame
			end
		end
	else
		return "Build Error."
	end
end

function service:getItemDesc(item)
	--Get the description of items.
	local itemExist = service.GetArrayItem(market,item)
	if itemExist then
		return itemExist.desc
	else
		return nil
	end
end

--Get the price of items.
function service:getItemValue(item)
	local itemExist = service.GetArrayItem(market,item)
	if itemExist then
		return itemExist.Price
	else
		warn("Item "..item.." does not exist in the market data.")
		return nil
	end
end

function service:getInventory(plr,frame,template)
	if plr then
		if workspace:FindFirstChild(tostring(plr.Name.." Inventory")) then
			for i,v in pairs(workspace[plr.Name.." Inventory"]:GetChildren()) do
				if v:FindFirstChild("className") then
					print(v.Name)
					if frame and template then
						local copy = template:Clone()
						copy.Name = v.Name
						copy.NameBox.Text = v.Name
						copy.Desc.Text = v.desc
						copy.Parent = frame
					end
				end
			end
		end
	else
		warn("No player found.")
	end
end

function service:PurchaseItem(item,plr)
	--Purchase the item and add it to the inventory folder.
	local itemExist = service.GetArrayItem(market,item)
	if item and plr and itemExist then
		--Free Items for now.
		local myItemClass = class:GetItemsClass(item)
		print(item,myItemClass)
		local myItem = class:GetItem(item,myItemClass)
		if myItem then
			myItem.Parent = workspace[plr.Name.." Inventory"]
		else
			warn("Item not found in rawItems.")
		end
	else
		warn("PurchaseItem run error. Item: "..item.."plr "..plr.Name)
	end
end

function service:SellItem(item,plr)
	--Sell an item for 70% of its origin value.
	local itemExist = service.GetArrayItem(market,item)
	if itemExist then
		-- local salePrice = (market[item].Price * 70)/100
		-- local money = plr.ChaoStats.Rings
		-- money.Value += salePrice
		if workspace[plr.Name.." Inventory"]:FindFirstChild(item.Name) then
			--Delete the item when they sell it.
			workspace[plr.Name.." Inventory"][item.Name]:Destroy()
			-- if salePrice >= 10000 then
			-- 	-- money.Value += 2500 --> A small bonus for selling an expensive item
			-- end
		end
	end
end

return service