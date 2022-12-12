--* Rewrite of the states system but on the client now

--[[
    States
    Handles animation and behavior of the chao
]]

--Collect the chao and the HumanoidObject
local chao = script.Parent
local hum = script.Parent.ChaoController
--run wait on task
local wait = task.wait
--initialize ChaoState
local ChaoState = chao.ChaoState
--define an actual player
local plr = game.Players.LocalPlayer
--Get ClassService so we can identify objects
local ClassService = require(game.ReplicatedStorage.PublicDependancies.ClassService)
--Get PathFindingService so we can make chao walk
local PFS = game:GetService("PathfindingService")
--Initialize PFS
local path = PFS:CreatePath()
--A boolean for checking if the chao is eating
--local isEating = false --todo: Gotta fix this
--A boolean that says if we're still running
local runningFinished = true
--A boolean to check if a chao is chasing food
local isHunger = false
--Current Anim
local currentlyPlaying = nil
--Create an Animation Object
local anim = Instance.new("Animation")
--Event for handling saveData related things
local eve = game.ReplicatedStorage.SaveData
--Event for recieving Held Event
local sig = game.ReplicatedStorage.pickSig

--list of sicknesses chao can get
local sicknesses = {
	"Cold",
	"Stomach Ache",
	"Cough",
	"Rash",
	"Hiccups",
	"Runny Nose",
}

--Debug Mode Printing
function dprint(text,i)
    if workspace.Debug.Value == true or i then
        print(text)
    end
end

--A function that changes states outside the main function. Exists since its used alot
function NewState(state)
	ChaoState.Value = state 
	dprint(chao.Name.." changed it's state to "..ChaoState.Value,true)
end

--Create a coroutine for moving the chao
function moveTp(pos)
	local startPos = script.Parent.HumanoidRootPart.Position
	local walls = workspace.Walls
	local outsideForce = false --Determines if this function has manipulated the final output position
	local goal
	--Loop through walls
	for i, v in pairs(walls:GetChildren()) do
		local magnitude = (startPos.Magnitude - v.Position.Magnitude)
		--Make sure nothing is blocking their path
		if magnitude <= 50 then
			--return them to the center
			goal = Vector3.new(1.52, 150.598, 247.34) --This is technically not the center but its where they will return to.
			outsideForce = true
		end
	end
	if outsideForce == false then
		goal = pos --If no manipulation, update the goal
	end
	--Move for each waypoint
	local waypoints
	local hum = script.Parent.ChaoController
	local success, failed = pcall(function()
		path:ComputeAsync(script.Parent.HumanoidRootPart.Position, goal)
	end)

	if success and path.Status == Enum.PathStatus.Success then
		waypoints = path:GetWaypoints()
		local lastTrip = 0
		for i, waypoint in pairs(waypoints) do --> Arrays don't start at zero. This is Lua. 
			if script.Parent.HumanoidRootPart.Held.Value == false then
				if waypoint.Action == Enum.PathWaypointAction.Jump then
					wait(1) --make the chao pause before jumping
					hum:ChangeState(Enum.HumanoidStateType.Jumping)
				end
				hum:MoveTo(waypoint.Position)
				--Do a luck check to determine if a chao tripped.
				local tripChance = math.random(1000) --Luck caps at 1000 for now
				local didTrip = 990 - plr.Leaderstats[chao.Name].LuckXP.Value
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
				break
			end
		end
		print("Held is true??")
		--Make chao Idle after running
		NewState("Idle")
		runningFinished = true
	else
		warn("Unable to compute path. "..tostring(failed))
		--if for whatever reason the pathfinding breaks return to idle.
		NewState("Idle")
		runningFinished = true
	end
end

--wrap the thread so we don't have to run coroutine.resume()
local startMovement = coroutine.wrap(moveTp)

function stateChanged() --Handles state changes
	print("Hey there.")
	print(ChaoState.Value)
	if ChaoState.Value == "Held" then --Held is the highest priority since it needs to override the other states
		dprint(chao.Name.." is being held.")
		while wait(1) do
			if script.Parent.HumanoidRootPart.Held.Value ~= true then
				print("stil held")
			end
		end
		NewState("Idle")
		dprint("We should be Idle.",true)
		stateChanged()
	elseif ChaoState.Value == "Sleeping" then
		--Send a sleep event so that the game knows that this chao is trying to sleep
        eve:FireServer(plr,"Sleep",chao)
	elseif ChaoState.Value == "Idle" then --Idle is higher priority than thinking since it always comes first
		dprint(chao.Name.." is idling.")
		wait(3)
		NewState("Thinking")
		dprint("We should be thinking.",true)
		stateChanged()
	elseif ChaoState.Value == "Thinking" then
		dprint(chao.Name.." is thinking.")
		wait(2)
		--This is where we can check if we want the chao to get sick.
		local sickTick = math.random(10000)
		if sickTick <= 45 then
			--The chao got sick
			local sickness = sicknesses[math.random(#sicknesses)]
			dprint(sickness)
			--Send a sick event so that the game knows that this chao is sick
            eve:FireServer(plr,"Sick",chao,sickness)
		end
		if script.Parent.HumanoidRootPart.Held.Value ~= false then
			NewState("Held")
			dprint("We should be held.",true)
			stateChanged()
		else
			--TODO: Chao should look for food. This needs to be rescripted since the old way was bad.
			--* Chao walk around
			dprint("We're walkin")
			local nextDest = Vector3.new(chao.HumanoidRootPart.Position.X+math.random(-100,100),chao.HumanoidRootPart.Position.Y,chao.HumanoidRootPart.Position.Z+math.random(-100,100))
			dprint(nextDest)
			NewState("Running")
			stateChanged()
			runningFinished = false
			moveTp(nextDest)
			repeat
				wait()
			until runningFinished == true
			stateChanged()
		end
	end
end

--This should initialize stateChanged
print("initializing...")
NewState("Idle")
stateChanged()
ChaoState.Changed:Connect(NewState)

--Runs on every frame.
-- RS.Heartbeat:Connect(function()
-- 	if ChaoState.Value == "Thinking" then
-- 		if currentlyPlaying ~= "Thinking" then
-- 			currentlyPlaying =  "Thinking"
-- 			if anim.IsPlaying == true then
-- 				anim:Stop()
-- 			end
-- 			anim.Id = "rbxassetid://" --Make anim
-- 			hum.Animator:LoadAnimation(anim)
-- 			anim:Play()
-- 		end
-- 	elseif ChaoState.Value == "Running" then
-- 		if currentlyPlaying ~= "Running" then
-- 			currentlyPlaying =  "Running"
-- 			if anim.IsPlaying == true then
-- 				anim:Stop()
-- 			end
-- 			if isHunger == true then
-- 				anim.Id = "rbxassetid://9420093988" 
-- 				hum.Animator:LoadAnimation(anim)
-- 				anim:Play()
-- 			else
-- 				if plr.Leaderstats[chao.Name].RunXP.Value >= 1500 then
-- 					anim.Id = "rbxassetid://9425958942" 
-- 					hum.Animator:LoadAnimation(anim)
-- 					anim:Play()
-- 				else
-- 					anim.Id = "rbxassetid://9438920009"
-- 					hum.Animator:LoadAnimation(anim)
-- 					anim:Play()
-- 				end
-- 			end
-- 		end
-- 	elseif ChaoState.Value == "Sitting" or ChaoState.Value == "Idle" or ChaoState.Value == "Held" then
-- 		if ChaoState.Value == "Sitting" then
-- 			if currentlyPlaying ~= "Sitting" then
-- 				currentlyPlaying =  "Sitting"
-- 				if anim.IsPlaying == true then
-- 					anim:Stop()
-- 				end
-- 				--TODO: Show different anims depending on chaos skill
-- 				anim.Id = "rbxassetid://" --Make anim
-- 				hum.Animator:LoadAnimation(anim)
-- 				anim:Play()
-- 			else
-- 				if currentlyPlaying ~= "Idle" then
-- 					currentlyPlaying =  "Idle"
-- 					if anim.IsPlaying == true then
-- 						anim:Stop()
-- 					end
-- 					--TODO: Show different anims depending on chaos skill
-- 					anim.Id = "rbxassetid://" --Make anim
-- 					hum.Animator:LoadAnimation(anim)
-- 					anim:Play()
-- 				end
-- 			end
-- 		end
-- 	elseif ChaoState.Value == "Swimming" then
-- 		if currentlyPlaying ~= "Swimming" then
-- 			currentlyPlaying =  "Swimming"
-- 			if anim.IsPlaying == true then
-- 				anim:Stop()
-- 			end
-- 			--TODO: Show different anims depending on chaos skill
-- 			anim.Id = "rbxassetid://" --Make anim
-- 			hum.Animator:LoadAnimation(anim)
-- 			anim:Play()
-- 		end
-- 	elseif ChaoState.Value == "Eating" then
-- 		if currentlyPlaying ~= "Eating" then
-- 			currentlyPlaying =  "Eating"
-- 			if anim.IsPlaying == true then
-- 				anim:Stop()
-- 			end
-- 			if plr.Leaderstats[chao.Name].Hunger.Value <= 50 then
-- 				anim.Id = "rbxassetid://9396895868"
-- 				hum.Animator:LoadAnimation(anim)
-- 				anim:Play()
-- 			else
-- 				anim.Id = "rbxassetid://9393483485"
-- 				hum.Animator:LoadAnimation(anim)
-- 				anim:Play()
-- 			end
-- 		end
-- 	end
-- end)