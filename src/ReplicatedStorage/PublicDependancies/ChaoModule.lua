print("Alive!")
math.randomseed(tick())

local repl = game.ReplicatedStorage

local module = {}
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
	--needed files
	--Interact Script
	--Emotions Script
	if chao.Hatched.Value == true then
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

return module

--[[
local rigObj = script.Parent:WaitForChild("CurrentRigObject")
local Shirt = workspace:WaitForChild("Shirt")
local Pants = workspace:WaitForChild("Pants")
local Colors = script.Parent:WaitForChild("Colors")
local obj = workspace:FindFirstChild(rigObj.Value)
local frame = Instance.new("ViewportFrame")
frame.Size = UDim2.new(0,1049,1,0)
frame.Position = UDim2.new(0.227,0,0,0)
frame.BackgroundColor3 = Color3.fromRGB(0,255,0)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.25
frame.ZIndex = 1
frame.Parent = script.Parent
local cam = Instance.new("Camera")
cam.Parent = frame
print(cam.Parent.Name)
cam.FieldOfView = 45

local humroot = obj:FindFirstChild("HumanoidRootPart")
frame.CurrentCamera = cam
local copy = obj:Clone()
copy.Parent = frame
copy.Name = "Rig"
cam.CFrame = CFrame.new(Vector3.new(0,2,12), humroot.Position)

rigObj.Changed:Connect(function()
    frame:ClearAllChildren() --removes every onject inside the frame
    local copyTarget = workspace:FindFirstChild(rigObj.Value)
    local copy = copyTarget:Clone()
    copy.Name = "Rig"
    humroot = copy:FindFirstChild("HumanoidRootPart")
    copy.Parent = frame
    local cam = Instance.new("Camera")
    cam.Parent = frame
    print(cam.Parent.Name)
    cam.FieldOfView = 45
    cam.CFrame = CFrame.new(Vector3.new(0,2,12), copy.HumanoidRootPart.Position)
    print("Trigger Recieved")
end)

Shirt.Changed:Connect(function()
    local copy = frame:FindFirstChild("Rig")
    local target = copy:FindFirstChild("Shirt")
    local tater = workspace:FindFirstChild("Shirt")
    if target and tater then
        target:Destroy()
        tater.Parent = copy
        print("Shirt Changed")
    end
end)

Pants.Changed:Connect(function()
    local copy = frame:FindFirstChild("Rig")
    local target = copy:FindFirstChild("Pants")
    local tater = workspace:FindFirstChild("Pants")
    if target and tater then
        target:Destroy()
        tater.Parent = copy
        print("Pants Changed")
    end
end) 

Colors.Changed:Connect(function()
    local copy = frame:FindFirstChild("Rig")
    local target = copy.SkinColor
    target.HeadColor3 = Colors.Value
    target.LeftArmColor3 = Colors.Value
    target.RightArmColor3 = Colors.Value
    target.LeftLegColor3 = Colors.Value
    target.RightLegColor3 = Colors.Value
    target.TorsoColor3 = Colors.Value
end)
]]