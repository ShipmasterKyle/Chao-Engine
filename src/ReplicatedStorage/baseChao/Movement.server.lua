--Depricate this. States handles movement and animations

-- math.randomseed(tick())
-- --Services
-- local PFS = game:GetService("PathfindingService")
-- local path = PFS:CreatePath()
-- local pathinprogress = false

-- --update wait()
-- local wait = task.wait

-- --TODO: Add states that the chao can use to show the correct animation.
-- --[[
-- 	States
-- 	Walk --> Chao is walking around.
-- 	Normal --> The Idle State.
-- 	Thinking --> The State that comes right before the walk state. The chao is deciding what to do.
-- 	Sleeping --> The chao is recharging it energy.
-- ]]

-- function followPath(object, goal)
-- 	local waypoints
-- 	local hum = object.Parent.Humanoid
-- 	local success, failed = pcall(function()
-- 		path:ComputeAsync(object.Position, goal)
-- 	end)

-- 	if success and path.Status == Enum.PathStatus.Success then
-- 		waypoints = path:GetWaypoints()
-- 		for i, waypoint in pairs(waypoints) do
-- 			if script.Parent.Held.Value == false then
-- 				if waypoint.Action == Enum.PathWaypointAction.Jump then
-- 					wait(1) --make the chao pause before jumping
-- 					hum:ChangeState(Enum.HumanoidStateType.Jumping)
-- 				end
-- 				hum:MoveTo(waypoint.Position)
-- 				hum.MoveToFinished:Wait(1)
-- 			else
-- 				break
-- 			end
-- 		end
-- 		pathinprogress = false
-- 	else
-- 		warn("Unable to compute path. "..tostring(failed))
-- 	end
-- end

-- local function generateMovement()
-- 	local startPos = script.Parent.HumanoidRootPart.Position
-- 	local walls = workspace.Walls
-- 	local outsideForce = false
-- 	local randomVector
-- 	for i, v in pairs(walls:GetChildren()) do
-- 		local magnitude = (startPos.Magnitude - v.Position.Magnitude)
-- 		if magnitude <= 100 then
-- 			--return them to the center
-- 			outsideForce = true
-- 			randomVector = Vector3.new(0,0,0) --where the origin will be
-- 		end
-- 	end
-- 	if outsideForce == false then
-- 		--Move around 100 studs
-- 		randomVector = Vector3.new(startPos.X+math.random(-100,100),startPos.Y,startPos.Z+math.random(-100,100)) --add
-- 	end
-- 	followPath(script.Parent.HumanoidRootPart, randomVector)
-- end


-- wait(5)

-- while wait(1) do
-- 	if script.Parent.Parent == workspace then
-- 		if script.Parent.Held.Value == false then
-- 			if pathinprogress == false then
-- 				generateMovement()
-- 			end
-- 		end
-- 	end
-- end