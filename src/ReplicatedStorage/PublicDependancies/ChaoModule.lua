--[[
	ChaoModule
	The main module for the garden. Handles stats
]]

print("Alive!")
math.randomseed(tick())

local repl = game.ReplicatedStorage
local visualService = require(script.Parent.VisualService)
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

--Table that handles traits
--Contains the headTexture as Id
local traitLoadout = {
	RedMono = {
		Id = "",
		Dom = 50
	},
	RedTwo = {
		Id = "",
		Dom = 65
	},
	OrangeMono = {
		Id = "",
		Dom = 45
	},
	OrangeTwo = {
		Id = "",
		Dom = 24
	},
	YellowMono = {
		Id = "",
		Dom = 70
	},
	YellowTwo = {
		Id = "",
		Dom = 30
	},
	GreenMono = {
		Id = "",
		Dom = 65
	},
	GreenTwo = {
		Id = "",
		Dom = 54
	},
	BlueMono = {
		Id = "",
		Dom = 75
	},
	BlueTwo = {
		Id = "",
		Dom = 51
	},
	SkyBlueMono = {
		Id = "",
		Dom = 80
	},
	SkyBlueTwo = {
		Id = "",
		Dom = 68
	},
	LimeMono = {
		Id = "",
		Dom = 40
	},
	LimeTwo = {
		Id = "",
		Dom = 35
	},
	PurpleMono = {
		Id = "",
		Dom = 25
	},
	PurpleTwo = {
		Id = "",
		Dom = 15
	},
	BrownMono = {
		Id = "",
		Dom = 10
	},
	BrownTwo = {
		Id = "",
		Dom = 9
	},
	GreyMono = {
		Id = "",
		Dom = 5
	},
	GreyTwo = {
		Id = "",
		Dom = 4
	},
	BlackMono = {
		Id = "",
		Dom = 17
	},
	BlackTwo = {
		Id = "",
		Dom = 20
	},
	WhiteMono = {
		Id = "",
		Dom = 90
	},
	WhiteTwo = {
		Id = "",
		Dom = 2
	}
}

function module:Export(chaoData,chao)
	--Format the save data to a file that can be transfered to ChaoLink.
	print("Ready.")
	local chaostring = ""
	--Store stats
	chaostring = chaostring.."ARx"..chaoData.SwimRank.Value..";"
	chaostring = chaostring.."BRx"..chaoData.FlyRank.Value..";"
	chaostring = chaostring.."CRx"..chaoData.RunRank.Value..";"
	chaostring = chaostring.."DRx"..chaoData.PowerRank.Value..";"
	chaostring = chaostring.."FRx"..chaoData.StaminaRank.Value..";"
	--TODO: Support intelligence and luck stats
	chaostring = chaostring.."ALxt"..chaoData.SwimXP.Value..";"
	chaostring = chaostring.."BLxt"..chaoData.FlyXP.Value..";"
	chaostring = chaostring.."CLxt"..chaoData.RunXP.Value..";"
	chaostring = chaostring.."DLxt"..chaoData.PowerXP.Value..";"
	chaostring = chaostring.."FLxt"..chaoData.StaminaXP.Value..";"
	--TODO: Support intelligence and luck stats
	chaostring = chaostring.."ALx"..chaoData.SwimLevel.Value..";"
	chaostring = chaostring.."BLx"..chaoData.FlyLevel.Value..";"
	chaostring = chaostring.."CLx"..chaoData.RunLevel.Value..";"
	chaostring = chaostring.."DLx"..chaoData.PowerLevel.Value..";"
	chaostring = chaostring.."FLx"..chaoData.StaminaLevel.Value..";"
	--Store color data
	--TODO: Support shiny and jewel chao
	local tone = visualService:returnTone(chao)
	if tone == "mono" then
		chaostring = chaostring.."iTSxF;"
	else
		chaostring = chaostring.."iTSxT;"
	end
	--Store chao types
	if chaoData.Ability.Value == "Hero" then
		chaostring = chaostring.."alRxH;"
	elseif chaoData.Ability.Value == "Dark" then
		chaostring = chaostring.."alRxD;"
	elseif chaoData.Ability.Value == "Normal" then
		chaostring = chaostring.."alRxN"
	else
		chaostring = chaostring.."alRxC"
	end
	if chaoData.Attribute.Value == "Swim" then
		chaostring = chaostring.."TRxA"
	elseif chaoData.Attribute.Value == "Fly" then
		chaostring = chaostring.."TRxB"
	elseif chaoData.Attribute.Value == "Run" then
		chaostring = chaostring.."TRxC"
	elseif chaoData.Attribute.Value == "Power" then
		chaostring = chaostring.."TRxD"
	elseif chaoData.Attribute.Value == "Stamina" then
		chaostring = chaostring.."TRxF"
	end
	--TODO: Support Chaos Chao
	chaostring = chaostring.."CCSxF"
	--TODO: Support Second Evolutions
	--Store Name
	chaostring = chaostring.."Namex"..chaoData.ChaoName.Value
	--Store Personality
	local person
	for i,v in pairs(personalityTable) do
		if v == chaoData.Personality.Value then
			person = i
			break
		else end
	end
	chaostring = chaostring.."PTRx"..person..";"
	--Store static variables
	chaostring = chaostring.."HzSX"..chaoData.Hunger.Value
	chaostring = chaostring.."TzSx"..chaoData.Tiredness.Value
	chaostring = chaostring.."CzSx"..chaoData.Condition.Value
	chaostring = chaostring.."HHSx"..chaoData.Happiness.Value
	chaostring = chaostring.."AzSX"..chaoData.Age.value
	--TODO: Support a Daycare system
	--chaostring = chaostring.."OzSX"..player.UserId
	return chaostring
end

--Change any data
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

--Level up on core stats
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

--Create a chao
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

--Spawn a chao
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

--hatch a chao egg
function module.Hatch(Egg,baseChao)
	if Egg then
		if baseChao then
			local hatchedEgg = repl.Broken_Egg:Clone()
			local goalPos = Egg.Position
			print(tostring(goalPos))
			hatchedEgg.Parent = workspace
			hatchedEgg:MoveTo(goalPos)
			Egg:Destroy()
			wait(3)
			local copy
			for i,v in pairs(repl.chaoStore:GetDescendants()) do
				if v:IsA("StringValue") then
					if v.Value == Egg.Identifier.Value then
						copy = v.Parent
					end
				end
			end
			copy.Parent = workspace
			copy.HumanoidRootPart.Position = goalPos
		else
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
		end
	else
		warn("No Egg to Hatch!")
	end
end

--Return a stat
function module:GetStats(ChaoData,player, stat)
	if player and stat then
		if player:FindFirstChild(ChaoData) then
			if player.ChaoData[ChaoData]:FindFirstChild(stat) then
				return player.ChaoData[ChaoData][stat].Value
			end
		end
	end
end

--Chao Evolution
function module:Evo(chaoData,chao,player)
	if player and chao then
		--Prevent the chao from Aging while evolving
		chaoData.canAge = false
		--Change ChaoState to sitting and play anim

		--Create Chao Cocoon
		local cocoon = game.ReplicatedStorage.ChaoCocoon --Path to chao cocoon.
		cocoon:Clone()
		cocoon.Parent = workspace
		cocoon.Position  = chao.HumanoidRootPart.Position + Vector3.new(0,3,0)

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

--Chao Reincarnation
function module:Rebirth(chaoData,chao,player)
	if player and chao then
		--Prevent the chao from Aging while evolving
		chaoData.canAge = false
		--Change ChaoState to sitting and play anim

		--Create Pink Cocoon
		local cocoon = game.ReplicatedStorage.PinkCocoon --Path to chao cocoon.
		cocoon:Clone()
		cocoon.Parent = workspace
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

--Handle Breeding chao stats
function module:BreedChao(chaoData1,chaoData2,chao1,chao2)
	--Determine what stats to take from who
	local chao1Stats = {}
	chao1Stats[1] = chaoData1.FlyXP.Value
	chao1Stats[2] = chaoData1.SwimXP.Value
	chao1Stats[3] = chaoData1.RunXP.Value
	chao1Stats[4] = chaoData1.PowerXP.Value
	chao1Stats[5] = chaoData1.StaminaXP.Value
	local chao2Stats = {}
	chao2Stats[1] = chaoData2.FlyXP.Value
	chao2Stats[2] = chaoData2.SwimXP.Value
	chao2Stats[3] = chaoData2.RunXP.Value
	chao2Stats[4] = chaoData2.PowerXP.Value
	chao2Stats[5] = chaoData2.StaminaXP.Value
	local newChaoStats = {}
	for count = 1,5 do
		local rand = math.random(2)
		if rand == 1 then
			newChaoStats[count] = chao1Stats[count]
		elseif rand == 2 then
			newChaoStats[count] = chao2Stats[count]
		end
	end
	--Decide the chao's color and color it with visual service
	local newChao = repl.baseChao:Clone()
	local color
	local isTwoTone
	--Basic Chao Punett Sqaure
	local chao1Color = chao1.Head.HeadMesh.Id
	local chao2Color = chao2.Head.HeadMesh.Id
	local compare1
	local compare2
	for i,v in pairs(traitLoadout) do
		if v.Id == chao1Color then
			compare1 = v.Dom
			isTwoTone = visualService:returnTone(chao1)
		elseif v.Id == chao2Color then
			compare2 = v.Dom
			isTwoTone = visualService:returnTone(chao2)
		end
	end
	if compare1 > compare2 then
		color = visualService:returnColor(chao1)
	elseif compare2 > compare1 then
		color = visualService:returnColor(chao2)
	end
	--Color chao with correct alleles
	if isTwoTone == "mono" then
		isTwoTone = false
	elseif isTwoTone == "two" then
		isTwoTone = true
	end
	visualService:ColorChao(newChao,color,isTwoTone)
	--add the newChao to cache
	newChao.Parent = game.ReplicatedStorage.chaoStore
	--add a few tags to link the chao to the egg.
	local vEx = Instance.new("StringValue")
	vEx.Name = "Identifier"
	vEx.Value = chao1.Name.."-"..chao2.Name
	local newEgg = repl.Egg:Clone()
	local tagCopy = vEx:Clone()
	tagCopy.Parent = newEgg
	tagCopy.Position = chao1.Position
	newEgg.Parent = workspace
end

return module