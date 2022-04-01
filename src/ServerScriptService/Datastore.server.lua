--TODO: Improve this
local module = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)-->Datastore uses folder from ChaoModule
local Datastore = game:GetService("DataStoreService")
local saveData = Datastore:GetDataStore("Sonic Earth Chao Garden")

game.Players.PlayerAdded:Connect(function(player)
	if player and module then
		wait(2)
		local folder = game.ReplicatedStorage.Folder:Clone()
		folder.Name = "ChaoData"
		folder.Parent = player
		--load data
		local data

		local success, errormessage = pcall(function(player)
			data = saveData:GetAsync("User_"..player.UserId) --finish this
		end)

		if success then
			--set values
			folder.Ability.Value = data.Ability
			folder.Age.Value = data.Age
			folder.Attribute.Value = data.Attribute
			folder.ChaoName.Value = data.ChaoName
			folder.Class.Value = data.ChaoClass
			folder.Condition.Value = data.Condition
			folder.FlyLevel.Value = data.FlyLevel
			folder.FlyRank.Value = data.FlyRank
			folder.FlyXP.Value = data.FlyXP
			folder.Happiness.Value = data.Happiness
			folder.Happiness.Value = data.Hunger
			folder.Hatched.Value = data.Hatched
			folder.Personality.Value = data.Personality
			folder.PowerLevel.Value = data.PowerLevel
			folder.PowerRank.Value = data.PowerRank
			folder.PowerXP.Value = data.PowerXP
			folder.RunLevel.Value = data.RunLevel
			folder.RunRank.Value = data.RunRank
			folder.RunXP.Value = data.RunXP
			folder.StaminaLevel.Value = data.StaminaLevel
			folder.StaminaRank.Value = data.StaminaRank
			folder.StaminaXP.Value = data.StaminaXP
			folder.SwimLevel.Value = data.SwimLevel
			folder.SwimXP.Value = data.SwimXP
			folder.spawn.Value = data.spawm
		end
	else
		warn("An error occured while loading data.")
	end
end)

--game.Players.PlayerRemoving:Connect(function(player)
--	local data = {}
--	for i,v in pairs(player.ChaoData:GetChildren()) do
--		table.insert(data, v.Value)
--	end
--	local success, errormessage = pcall(function()
--		saveData:SetAsync("User_"..player.UserId, data)
--	end)
--	if success then
--		print("Save Data Saved Sucessfully!")
--	else
--		warn("An Error Occured while saving save data to server")
--		warn(errormessage)
--	end
--end)