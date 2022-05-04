local Datastore = game:GetService("DataStoreService")
--TODO: Load the main game datastore here
local saveData = Datastore:GetDataStore("Sonic Earth Chao Garden Alpha")
--Instead of generating a new folder every time with the old Main script simply generate a new folder only if we need to.
local module = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)

game.Players.PlayerAdded:Connect(function(player)
	workspace.currentGarden.Value = "Lobby"
	if player and module then
		--Create a chaoData folder TODO: Change the name of this so something like chaoData so it doesn't conflict with the main game saves
		local main = Instance.new("Folder")
		main.Name = "Leaderstats"
		main.Parent = player
		local lastlt = Instance.new("StringValue")
		lastlt.Name = "lastLogTime"
		lastlt.Parent = main
		--Create the folder for the data
		local folder = game.ReplicatedStorage.GardenFolder:Clone()
		folder.Parent = main
		--load data
		--[[
			I've came up with an extremely intelligent idea for multiple chao support.
			Basically we have several data groups
			Garden
				ID: "Garden_"player.UserID
				Stores all the garden data and other global stats. Also stores how many chao are in the garden.
			Chao1-8 (Currently only supporting up to 8 chao)
				ID: "Chao(1-8)_"player.UserID
				Chao Data. All Chao will have an ID stored as a String Value so for example if my user ID
				is 3456384 and this was chao 3 ot would be "Chao3_3456384"
			Daycare
				ID "Daycare_"player.UserID
				Stores one chao that you picked up from the daycare.
		]]
		--Load the garden data
		local data = saveData:GetAsync("Garden_"..player.UserId)
		
		--Rewriting this. Now it'll load the garden data then the rest
		if data then
			for i,v in pairs(folder:GetChildren()) do
				v.Value = data[v]
			end
			folder.Name = "Garden"
			local chaoCount = folder.ChaoCount
			--TODO: Optimize this
			if chaoCount.Value >= 1 then
				local data = saveData:GetAsync("Chao1_"..player.UserId)
				local chaoFolder = game.ReplicatedStorage.Folder:Clone()
				for i,v in pairs(chaoFolder:GetChildren()) do
					v.Value = data[v]
				end
				chaoFolder.Name = data.ChaoName
				chaoFolder.Parent = main
				local chao1 = module.spawnChao(chaoFolder,true)
				chao1:SetAttribute("ID","chao1")
			end
			if chaoCount.Value >= 2 then
				local data = saveData:GetAsync("Chao2_"..player.UserId)
				local chaoFolder = game.ReplicatedStorage.Folder:Clone()
				for i,v in pairs(chaoFolder:GetChildren()) do
					v.Value = data[v]
				end
				chaoFolder.Parent = main
				chaoFolder.Name = data.ChaoName
				local chao2 = module.spawnChao(chaoFolder,true)
				chao2:SetAttribute("ID","chao2")
			--Will add the rest later. For now lets use these for testing
			end
		else
			print("Creating new data!")
			--Initalize a brand new garden.
			local folder = module:CreateNew()
			wait(1)
			local chao1data = module.newChao()
			local chao1 = module.spawnChao(chao1data,true)
			chao1:SetAttribute("ID","chao1")
			folder.ChaoCount.Value += 1
			local chao2data = module.newChao()
			local chao2 = module.spawnChao(chao1data,true)
			chao2:SetAttribute("ID","chao2")
			folder.ChaoCount.Value += 1 --Should be two now
			print("Two new chao!")
		end
	end
end)

function createSaveTable(player,table)
	-- local clock = os.time()
	-- player.Leaderstats.lastLogTime.Value = clock
	-- print(player.Leaderstats.lastLogTime.Value)
	local saveTable = {}
	for i,v in pairs(player.Leaderstats[table]) do
		if not v:IsA("Folder") then
			saveTable[v.Name] = v.Value
		end
	end
	return saveTable
end

--TODO: Create a callback to save the player's money on purchases

--Rewrite this.
game.Players.PlayerRemoving:Connect(function(player)
	local data = createSaveTable(player,"Garden")
	local success, errormessage = pcall(function()
		saveData:SetAsync("Garden_"..player.UserId)
	end)
	if success then
		print("Garden Data Saved Sucessfully!")
	else
		warn("An Error Occured while saving save data to server")
		warn(errormessage)
	end
end)