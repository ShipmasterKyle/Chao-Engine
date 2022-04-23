--[[
    Makes deleting data possible
]]

--Get dss
local Datastore = game:GetService("DataStoreService")
local saveData = Datastore:GetDataStore("Sonic Earth Chao Garden Alpha")

--Get chao death event
local rmv = game.ReplicatedStorage.Remotes.RemoveChao

--Chao Death
rmv.Event:Connect(function(chaoData,chao,player)
	if chaoData and chao then
		--Prevent the chao from Aging while evolving
		chaoData.canAge = false
		--Change ChaoState to sitting and play anim
		
		--Create White Cocoon
		local cocoon = game.ReplicatedStorage.Cocoon--Path to chao cocoon.
		cocoon:Clone()
		cocoon.Parent = workspace
		cocoon.Position  = chao.HumanoidRootPart.Position
		--Destroy ChaoData
		local wasInterupted = false
		for i,v in pairs(chaoData:GetChildren()) do
			local success, response = pcall(function(v)
				local save_data = saveData:GetAsync("User_"..player.UserId)
				save_data.Data[v] = nil
				saveData:SetAsync("User_"..player.UserId,save_data)
			end)
			if not success then
				print(response)
				wasInterupted = true
				break
			else end
		end
		--destroy the folder itself
		if wasInterupted == false then --ensure the data actually got deleted
			chaoData:Destroy()
		end
		--remove chao
		chao:Destroy()
		--Remove Cocoon
		for count = 1,100 do
			cocoon.Transparency -= 0.01
		end
		cocoon:Destroy()
	end
end)