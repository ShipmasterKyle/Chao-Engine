--[[
    States
    Handles animating the chao
]]

--Collect the chao and the HumanoidObject
local chao = script.Parent
local hum = script.Parent.ChaoController
--Get the runtime.
local RS = game:GetService("RunService")
--run wait on task
local wait = task.wait
--ChaoState
local ChaoState = chao:GetAttribute("ChaoState")
chao:SetAttribute("ChaoState","Idle")
--define an empty player value
local plr
--Get ClassService so we can identify objects
local ClassService = require(game.ReplicatedStorage.PublicDependancies.ClassService)
--Get PathFindingService so we can make chao walk
local PFS = game:GetService("PathfindingService")
local path = PFS:CreatePath()
--A boolean for checking if the chao is eating
local isEating = false
--A boolean to check if a chao is chasing food
local isHunger = false
--Current Anim
local currentlyPlaying = nil
--Create an Animation Object
local anim = Instance.new("Animation")

local sicknesses = {
	"Cold",
	"Stomach Ache",
	"Cough",
	"Rash",
	"Hiccups",
	"Runny Nose",
}

game.Players.PlayerAdded:Connect(function(player)
	--set the empty player value to a valid player
	plr = player
end)

repeat wait() until script.Parent.Parent == workspace
-- wait(3)
--Make sure the chao is marked as hatched.
-- plr.Leaderstats[chao.Name].Hatched.Value = true

--A function that changes states outside the coroutine
function NewState(state)
	chao:SetAttribute("ChaoState",state)
end

--Create a coroutine for sleeping chao
local chargeChao = coroutine.create(function()
	plr.Leaderstats[chao.Name].isSleeping.Value = true
	repeat
		--Process takes about 15 minutes
		wait(9)
		plr.Leaderstats[chao.Name].Energy.Value += 1
	until plr.Leaderstats[chao.Name].Energy.Value == 100
end)

--Create a coroutine for moving the chao
local startMovement = coroutine.create(function(pos)
	local startPos = script.Parent.HumanoidRootPart.Position
	local walls = workspace.Walls
	local outsideForce = false
	local goal
	--Loop through walls
	for i, v in pairs(walls:GetChildren()) do
		local magnitude = (startPos.Magnitude - v.Position.Magnitude)
		--Make sure nothing is blocking their path
		if magnitude <= 100 then
			--return them to the center
			goal = Vector3.new(0,0,0) --TODO: Update this number
			outsideForce = true
		end
	end
	if outsideForce == false then
		goal = pos
	end
	--Move for each waypoint
	local waypoints
	local hum = script.Parent.ChaoController
	local success, failed = pcall(function()
		path:ComputeAsync(script.Parent.HumanoidRootPart.Position, goal)
	end)

	if success and path.Status == Enum.PathStatus.Success then
		waypoints = path:GetWaypoints()
		local lastTrip = 0 --> Arrays start at zero. Funny. Very funny. This is Lua. We don't do that here.
		for i, waypoint in pairs(waypoints) do
			if script.Parent.Held.Value == false then
				if waypoint.Action == Enum.PathWaypointAction.Jump then
					wait(1) --make the chao pause before jumping
					hum:ChangeState(Enum.HumanoidStateType.Jumping)
				end
				hum:MoveTo(waypoint.Position)
				--Do a luck check to determine if a chao tripped.
				local tripChance = math.random(1000) --Luck caps at 1000 for now
				local didTrip = 999 - plr.Leaderstats[chao.Name].LuckXP.Value
				if didTrip >= tripChance and lastTrip >= i - 2 --[[>Prevents tripping back to back<]] then
					--They did trip
					lastTrip = i
					NewState("Tripped")
					hum.MoveToFinished:Wait(3)
				else
					--They didn't trip
					hum.MoveToFinished:Wait(1)
				end
			else
				--Setting the state to held is handled later on
				break
			end
		end
		--Make chao Idle after running
		NewState("Idle")
	else
		warn("Unable to compute path. "..tostring(failed))
		--if for whatever reason the pathfinding breaks return to idle.
		NewState("Idle")
	end
end)

--Create a couroutine that runs while the main function runs
local stateChanged = coroutine.create(function()
	print("Chao State Changed! NewState: "..chao:GetAttribute("ChaoState"))
	print(ChaoState .." This should match the above.")
	if ChaoState == "Idle" or ChaoState == "Sitting" then
		print("Idling")
		wait(5)
		print("Finished")
		NewState("Thinking")
	end
	if ChaoState == "Thinking" then
		wait(2)
		--Do a random tick to decide if chao will get sick and if they do with what
		local sickTick = math.random(10000)
		if sickTick <= 45 then
			--The chao got sick
			local sickness = sicknesses[math.random(#sicknesses)]
			print(sickness)
			plr.Leaderstats[chao.Name].Condition.Value = sickness
		end
		if plr.Leaderstats[chao.Name].Hunger.Value <= 30 then
			--Loop through the player and see if they're holding food.
			for i,v in pairs(plr.Character:GetDecendants()) do
				if ClassService:GetItemsClass(v.Name) == "Food" then
					coroutine.resume(startMovement,plr.Character.HumanoidRootPart.Position)
					NewState("Running")
					isHunger = true
					break 
				else end
			end
			--Just walk around
			local nextDest = Vector3.new(chao.HumanoidRootPart.Position.X+math.random(-100,100),chao.HumanoidRootPart.Position.Y,chao.HumanoidRootPart.Position.Z+math.random(-100,100))
			NewState("Running")
			coroutine.resume(startMovement,nextDest)
		elseif plr.Leaderstats[chao.Name].Energy <= 0 then
			--Make chao fall asleep
			--Waiting on Alberto for anim
			NewState("Sleeping")
		else
			--Just walk around
			local nextDest = Vector3.new(chao.HumanoidRootPart.Position.X+math.random(-100,100),chao.HumanoidRootPart.Position.Y,chao.HumanoidRootPart.Position.Z+math.random(-100,100))
			NewState("Running")
			coroutine.resume(startMovement,nextDest)
		end
	end
	if ChaoState == "Sleeping" then
		coroutine.resume(chargeChao)
	end
	if ChaoState == "Eating" then
		isEating = true
		isHunger = false
		repeat wait() until isEating == false
		if plr.Leaderstats[chao.Name].Energy <= 0 then
			--Make chao fall asleep
			--Waiting on Alberto for anim
			NewState("Sleeping")
		else
			--Randomize next pos
			local nextDest = Vector3.new(chao.HumanoidRootPart.Position.X+math.random(-100,100),chao.HumanoidRootPart.Position.Y,chao.HumanoidRootPart.Position.Z+math.random(-100,100))
			NewState("Running")
			coroutine.resume(startMovement,nextDest)
		end
	end
	if ChaoState == "Held" then
		repeat wait() until script.Parent.Held.Value == false
	end
end)


--Change the chao's state to swimming if they're touching a part named "Water"
chao.HumanoidRootPart.Touched:Connect(function(hit)
	if hit.Name == "Water" and script.Parent.Held.Value == false then
		NewState("Swimming")
	end
end)

chao.HumanoidRootPart.Held.Changed:Connect(function()
	if chao.Held.Value == true then
		NewState("Held")
	else
		NewState("Idle")
	end
end)


chao:GetAttributeChangedSignal("ChaoState"):Connect(function()
	coroutine.resume(stateChanged)
end)

coroutine.resume(stateChanged)
--Runs on every frame.
RS.Heartbeat:Connect(function()
	if ChaoState == "Thinking" then
		if currentlyPlaying ~= "Thinking" then
			currentlyPlaying =  "Thinking"
			if anim.IsPlaying == true then
				anim:Stop()
			end
			anim.Id = "rbxassetid://" --Make anim
			hum.Animator:LoadAnimation(anim)
			anim:Play()
		end
	elseif ChaoState == "Running" then
		if currentlyPlaying ~= "Running" then
			currentlyPlaying =  "Running"
			if anim.IsPlaying == true then
				anim:Stop()
			end
			if isHunger == true then
				anim.Id = "rbxassetid://9420093988" 
				hum.Animator:LoadAnimation(anim)
				anim:Play()
			else
				if plr.Leaderstats[chao.Name].RunXP.Value >= 1500 then
					anim.Id = "rbxassetid://9425958942" 
					hum.Animator:LoadAnimation(anim)
					anim:Play()
				else
					anim.Id = "rbxassetid://9438920009"
					hum.Animator:LoadAnimation(anim)
					anim:Play()
				end
			end
		end
	elseif ChaoState == "Sitting" or ChaoState == "Idle" or ChaoState == "Held" then
		if ChaoState == "Sitting" then
			if currentlyPlaying ~= "Sitting" then
				currentlyPlaying =  "Sitting"
				if anim.IsPlaying == true then
					anim:Stop()
				end
				--TODO: Show different anims depending on chaos skill
				anim.Id = "rbxassetid://" --Make anim
				hum.Animator:LoadAnimation(anim)
				anim:Play()
			else
				if currentlyPlaying ~= "Idle" then
					currentlyPlaying =  "Idle"
					if anim.IsPlaying == true then
						anim:Stop()
					end
					--TODO: Show different anims depending on chaos skill
					anim.Id = "rbxassetid://" --Make anim
					hum.Animator:LoadAnimation(anim)
					anim:Play()
				end
			end
		end
	elseif ChaoState == "Swimming" then
		if currentlyPlaying ~= "Swimming" then
			currentlyPlaying =  "Swimming"
			if anim.IsPlaying == true then
				anim:Stop()
			end
			--TODO: Show different anims depending on chaos skill
			anim.Id = "rbxassetid://" --Make anim
			hum.Animator:LoadAnimation(anim)
			anim:Play()
		end
	elseif ChaoState == "Eating" then
		if currentlyPlaying ~= "Eating" then
			currentlyPlaying =  "Eating"
			if anim.IsPlaying == true then
				anim:Stop()
			end
			if plr.Leaderstats[chao.Name].Hunger.Value <= 50 then
				anim.Id = "rbxassetid://9396895868"
				hum.Animator:LoadAnimation(anim)
				anim:Play()
			else
				anim.Id = "rbxassetid://9393483485"
				hum.Animator:LoadAnimation(anim)
				anim:Play()
			end
		end
	end
end)