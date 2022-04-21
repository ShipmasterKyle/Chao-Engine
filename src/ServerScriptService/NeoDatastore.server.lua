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
		local lastlt = Instance.new("IntValue")
		lastlt.Name = "lastLogTime"
		--Create the folder for the data
		local folder = game.ReplicatedStorage.Folder:Clone()
		--Don't change the name. We'll be naming it to the chao's name
		folder.Parent = main
		--load data
		local data = saveData:GetAsync("User_"..player.UserId)

		if data then
			for i,v in pairs(folder:GetChildren()) do
				v.Value = data[v]
			end
			folder.Name = data.ChaoName
		else
			print("Creating new data!")
			module.newChao()
			print("SaveData Ready")
		end
	end
end)

function createSaveTable(player)
	player.Leaderstats.lastLogTime.Value = os.time()
	local saveTable = {}
	for i,v in pairs(player.Leaderstats:GetDescendants()) do
		if not v:IsA("Folder") then
			saveTable[v.Name] = v.Value
		end
	end
	return saveTable
end

--TODO: Create a callback to save the player's money on purchases

game.Players.PlayerRemoving:Connect(function(player)
	local data = createSaveTable(player)
	local success, errormessage = pcall(function()
		saveData:SetAsync("User_"..player.UserId, data)
	end)
	if success then
		print("Save Data Saved Sucessfully!")
	else
		warn("An Error Occured while saving save data to server")
		warn(errormessage)
	end
end)