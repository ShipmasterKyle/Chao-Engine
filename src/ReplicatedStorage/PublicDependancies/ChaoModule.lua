print("Alive!")
math.randomseed(tick())

local repl = game.ReplicatedStorage
local visualService = require(script.Parent.VisualService)
local Datastore = game:GetService("DataStoreService")
local saveData = Datastore:GetDataStore("Sonic Earth Chao Garden Alpha")
local module = {}

--Moved out of the createChao function since we need this in the rebirth.
local personalityTable = {
	--Adding more in the future.
	"Gentle",
	"Naughty",
	"Energetic",
	"Quiet",
	"Big Eater",
	"Chatty",
	"Easily Bored",
	"Curious",
	"Carefree",
	"Careless",
	"Smart",
	"Cry Baby",
	"Lonely",
	"Naive"
}

function module.chaoDataexport()
	--Format the save data to a file that can be transered throughtout games using HTTPservice. I'll work on this later on.
	print("Ready.")
end

function module.changeData(stat,value,chaoData)
	if chaoData then
		if stat and value then
			local data = chaoData:FindFirstChild(stat)
			if data then
				local isNumber = tonumber(value)
				if isNumber then
					chaoData[stat].Value += value
				else 
					chaoData[stat].Value = value
				end
			else
				warn("Data doesn't exist")
			end
		end
	else
		warn("Invalid ChaoData")
	end
end

function module.changeStat(stat,value,chaoData)
	if chaoData then
		if stat and value then
			if stat == "Run" then
				local mx = chaoData.RunRank.Value
				local trueValue = value*mx
				chaoData.RunXP.Value += trueValue
				if chaoData.RunXP.Value >= chaoData.RunLevel.Value * 100 and chaoData.RunLevel.Value ~= 99 then
					chaoData.RunLevel.Value += 1
				end
			end
			if stat == "Power" then
				local mx = chaoData.PowerRank.Value
				local trueValue = value*mx
				chaoData.PowerXP.Value += trueValue
				if chaoData.PowerXP.Value >= chaoData.PowerLevel.Value * 100 and chaoData.PowerLevel.Value ~= 99 then
					chaoData.PowerLevel.Value += 1
				end
			end
			if stat == "Swim" then
				local mx = chaoData.SwimRank.Value
				local trueValue = value*mx
				chaoData.SwimXP.Value += trueValue
				if chaoData.SwimXP.Value >= chaoData.SwimLevel.Value * 100 and chaoData.SwimLevel.Value ~= 99 then
					chaoData.SwimLevel.Value += 1
				end
			end
			if stat == "Fly" then
				local mx = chaoData.FlyRank.Value
				local trueValue = value*mx
				chaoData.FlyXP.Value += trueValue
				if chaoData.FlyXP.Value >= chaoData.FlyLevel.Value * 100 and chaoData.FlyLevel.Value ~= 99 then
					chaoData.FlyLevel.Value += 1
				end
			end
			if stat == "Stamina" then
				local mx = chaoData.StaminaRank.Value
				local trueValue = value*mx
				chaoData.StaminaXP.Value += trueValue
				if chaoData.StaminaXP.Value >= chaoData.StaminaLevel.Value * 100 and chaoData.StaminaLevel.Value ~= 99 then
					chaoData.StaminaLevel.Value += 1
				end
			end
		end
	else
		warn("Invalid ChaoData")
	end
end

function module.newChao()
	print("Ready!")
	--generate stats
	local folder = game.ReplicatedStorage.Folder
	local rng = math.random(5)
	local statTable = {
		1,
		1,
		1,
		1,
		1
	}
	--fills the stats table and makes it so only one stat can be an A. This isn't for the genepool.
	local hasfive = false
	for i,v in pairs(statTable) do
		if not hasfive then
			local rng = math.random(5)
			statTable[i] = rng
			if rng == 5 then
				hasfive = true
			end
		else
			statTable[i] = math.random(4)
		end
	end
	folder.SwimRank.Value = statTable[1]
	folder.FlyRank.Value = statTable[2]
	folder.RunRank.Value = statTable[3]
	folder.PowerRank.Value = statTable[4]
	folder.StaminaRank.Value = statTable[5]
	folder.Age.Value = 0
	folder.Class.Value = 0
	folder.Attribute.Value = "Child"
	folder.Condition.Value = "none"
	folder.Happiness.Value = 50
	folder.Hunger.Value = 1
	local trng = math.random(#personalityTable)
	folder.Personality.Value = personalityTable[trng]
	--Here we randomize the position of the chao. I'll do that later on
	folder.Hatched.Value = false
	print("Done. New Chao Data made.")
	return folder
end

function module.spawnChao(chao) --chaoData
	if chao.Hatched.Value == true then
		--spawn a chao
		local copy = repl.baseChao:Clone()
		copy.Parent = workspace
		copy.HumanoidRootPart.Position = Vector3.new(10,0,10) --TODO: Randomize this
	else
		--spawn a chao egg
		local copy = repl.Egg:Clone()
		copy.Parent = workspace
		copy.Position = Vector3.new(170.047, 171.708, 256.577) --TODO: Randomize this
	end
end

function module.Hatch(Egg)
	if Egg then
		local hatchedEgg = repl.Broken_Egg:Clone()
		local goalPos = Egg.Position
		print(tostring(goalPos))
		hatchedEgg.Parent = workspace
		hatchedEgg:MoveTo(goalPos)
		Egg:Destroy()
		wait(3)
		local copy = repl.baseChao:Clone()
		copy.Parent = workspace
		copy.HumanoidRootPart.Position = goalPos
	else
		warn("No Egg to Hatch!")
	end
end

function module:GetStats(ChaoData,player, stat)
	if player and stat then
		if player:FindFirstChild(ChaoData) then
			if player.ChaoData[ChaoData]:FindFirstChild(stat) then
				return player.ChaoData[ChaoData][stat].Value
			end
		end
	end
end

function module:Evo(chaoData,chao,player)
	if player and chao then
		--Prevent the chao from Aging while evolving
		chaoData.canAge = false
		--Change ChaoState to sitting and play anim

		--Create Chao Cocoon
		local cocoon --Path to chao cocoon.
		cocoon:Clone()
		coccon.Parent = workspace
		cocoon.Position  = chao.HumanoidRootPart.Position

		--Determine Ability Evolution
		local chaoType
		if chaoData.AbilityDirection.Value >= 0.5 then
			chaoType = "Hero"
		elseif chaoData.AbilityDirection.Value <= -0.5 then
			chaoType = "Dark"
		else
			chaoType = "Normal"
		end 
		--Apply Visual Changes
		visualService:ChangeHeadType(chao,chaoType)
		--Apply SaveData Changes
		chaoData.Ability.Value = chaoType
		--Determine Type Evolution
		if chaoData.LastUpgraded == "Swim" then
			chaoType = "Swim"
		elseif chaoData.LastUpgraded == "Fly" then
			chaoType = "Fly"
		elseif chaoData.LastUpgraded == "Run" then
			chaoType = "Run"
		elseif chaoData.LastUpgraded == "Power" then
			chaoType = "Power"
		end
		--Apply Visual Changes
		visualService:ChangeChaoType(chao,chaoType)
		--Apply SaveData Changes
		chaoData.Attribute.Value = chaoType
		--Remove Cocoon
		for count = 1,100 do
			cocoon.Transparency -= 0.01
		end
		cocoon:Destroy()
		--Clean up
		chaoData.canAge = true
	end
end

function module:Rebirth(chaoData,chao,player)
	if player and chao then
		--Prevent the chao from Aging while evolving
		chaoData.canAge = false
		--Change ChaoState to sitting and play anim

		--Create Pink Cocoon
		local cocoon --Path to chao cocoon.
		cocoon:Clone()
		coccon.Parent = workspace
		cocoon.Position  = chao.HumanoidRootPart.Position
		--Reset every stat to 10 percent of its current value
		chaoData.FlyXP.Value = math.floor(chaoData.FlyXP.Value*10/100)
		chaoData.SwimXP.Value = math.floor(chaoData.SwimXP.Value*10/100)
		chaoData.RunXP.Value = math.floor(chaoData.RunXP.Value*10/100)
		chaoData.PowerXP.Value = math.floor(chaoData.PowerXP.Value*10/100)
		chaoData.StaminaXP.Value = math.floor(chaoData.StaminaXP.Value*10/100)
		--Reset personaility
		local prng = math.random(#personalityTable)
		chaoData.Personality.Value = personalityTable[prng]
		--Reset Age
		chaoData.Age.Value = 0
		--Reset attribute and ablility
		chaoData.Attribute.Value = "Child"
		chaoData.AbilityDirection = 0
		chaoData.Ability.Value = ""
		--Remove Cocoon
		for count = 1,100 do
			cocoon.Transparency -= 0.01
		end
		cocoon:Destroy()
		--Clean up
		chaoData.canAge = true
	end
end

function module:RemoveChao(chaoData,chao,player)
	if chaoData and chao then
		--Prevent the chao from Aging while evolving
		chaoData.canAge = false
		--Change ChaoState to sitting and play anim

		--Create White Cocoon
		local cocoon --Path to chao cocoon.
		cocoon:Clone()
		coccon.Parent = workspace
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
end

return module