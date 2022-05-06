--[[
    States
    Handles animating the chao
]]

--Collect the chao and the HumanoidObject
local chao = script.Parent
local hum = script.Parent.ChaoController
--Get the runtime.
local RS = game:GetService("RunService")
--ChaoState
local ChaoState = chao:GetAttribute("ChaoState")
chao:SetAttribute("ChaoState","Idle")
--define an empty player value
local plr
--Get ClassService so we can identify objects
ClassService = require(game.ReplicatedStorage.PublicDependancies.ClassService)
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

game.Players.PlayerAdded:Connect(function(player)
	--set the empty player value to a valid player
	plr = player
end)

repeat wait() until script.Parent.Parent == workspace

--Make sure the chao is marked as hatched.
plr.Leaderstats[chao.Name].Hatched.Value = true

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
		for i, waypoint in pairs(waypoints) do
			if script.Parent.Held.Value == false then
				if waypoint.Action == Enum.PathWaypointAction.Jump then
					wait(1) --make the chao pause before jumping
					hum:ChangeState(Enum.HumanoidStateType.Jumping)
				end
				hum:MoveTo(waypoint.Position)
				hum.MoveToFinished:Wait(1)
			else
				break
			end
		end
	else
		warn("Unable to compute path. "..tostring(failed))
	end
end)

--Create a couroutine that runs while the main function runs
local stateChanged = coroutine.create(function()
	if ChaoState == "Idle" or ChaoState == "Sitting" then
		wait(5)
		chao:SetAttribute("ChaoState","Thinking")
	end
	if ChaoState == "Thinking" then
		wait(2)
		if plr.Leaderstats[chao.Name].Hunger.Value <= 30 then
			--Loop through the player and see if they're holding food.
			for i,v in pairs(plr.Character:GetDecendants()) do
				if ClassService:GetItemsClass(v.Name) == "Food" then
					coroutine.resume(startMovement,plr.Character.HumanoidRootPart.Position)
					chao:SetAttribute("ChaoState","Running")
					isHunger = true
				end
			end
		elseif plr.Leaderstats[chao.Name].Energy <= 0 then
			--Make chao fall asleep
			--Waiting on Alberto for anim
			chao:SetAttribute("ChaoState","Sleeping")
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
			chao:SetAttribute("ChaoState","Sleeping")
		else
			--Randomize next pos
			local nextDest = Vector3.new(chao.HumanoidRootPart.Position.X+math.random(-100,100),chao.HumanoidRootPart.Position.Y,chao.HumanoidRootPart.Position.Z+math.random(-100,100))
			chao:SetAttribute("ChaoState","Running")
			coroutine.resume(startMovement,plr.Character.HumanoidRootPart.Position)
		end
	end
	if ChaoState == "Held" then
		repeat wait() until script.Parent.Held.Value == false
	end
end)


--Change the chao's state to swimming if they're touching a part named "Water"
chao.HumanoidRootPart.Touched:Connect(function(hit)
	if hit.Name == "Water" and script.Parent.Held.Value == false then
		ChaoState = "Swimming"
	end
end)


chao:GetAttributeChangedSignal("ChaoState"):Connect(function()
	coroutine.resume(stateChanged)
end)

coroutine.resume(stateChanged)

print("Running")
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
	print(ChaoState)
end)

--For reference
--[[
	--Check the humState
	if humState == Enum.HumanoidStateType.Running then
		if ChaoState == "Swimming" then
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
		elseif ChaoState == "none" then
			if currentlyPlaying ~= "Running" then
				currentlyPlaying =  "Running"
				if anim.IsPlaying == true then
					anim:Stop()
				end
				--TODO: Show different anims depending on chaos skill
				anim.Id = "rbxassetid://" --Make anim
				hum.Animator:LoadAnimation(anim)
				anim:Play()
			end
		end
	elseif humState == Enum.HumanoidStateType.Freefall then
		if currentlyPlaying ~= "Flying" then
			--TODO: Check if they can actually fly
			currentlyPlaying = "Flying"
			if anim.IsPlaying == true then
				anim:Stop()
			end
			anim.Id = "rbxassetid://" --Make anim
			hum.Animator:LoadAnimation(anim)
			anim:Play()
		end
	else
		if currentlyPlaying ~= "Idle" then
			currentlyPlaying =  "Idle"
			if anim.IsPlaying == true then
				anim:Stop()
			end
			anim.Id = "rbxassetid://" --Make anim
			hum.Animator:LoadAnimation(anim)
			anim:Play()
		end
	end
]]