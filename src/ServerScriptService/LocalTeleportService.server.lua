local debound = false
local wait = task.wait
local garden = workspace.currentGarde
local players = game.Players

--getDoors will return a Gate's CFrame that matches the recieved door nane,
function getDoors(doorName)
	local found = false
	for i,v in pairs(workspace.Doors.Gate:GetChildren()) do
		local temp = v:GetAttribute("DoorName")
		if temp == doorName then
			found = true
			return v.CFrame
		end
	end
	if found == false then
		return false
	end
end

--This is the main loop that detects when the player hits a door
while wait() do
	for i,v in pairs(workspace.Doors:GetChildren()) do
		if v:IsA("Part") then
			v.Touched:Connect(function(hit))
				if debound == false then --Only run if not debound
					debound == true
					local player = game.Players:GetPlayerFromCharacter(hit.Parent)
					if player then
						garden.Value = "loading"
					else
						debound = false
						print("Teleporting...")
						local doorName = v:GetAttribute("DoorName")
						if doorName then
							local goal = getDoors(doorName)
							if goal then
								hit.Parent:SetPrimaryPartCFrame(goal)
								garden.Value = doorName
							end
						end
					end
				end
			end
		end
	end
end


-- while wait() do
-- 	for i,v in pairs(workspace.Doors:GetChildren()) do
-- 		if v:IsA("Part") then
-- 			v.Touched:Connect(function(hit)
-- 				if debound == false then
-- 					debound = true
-- 				end
-- 				local player = game.Players:GetPlayerFromCharacter(character)
-- 				if  then --this breaks then holding system so we're gona rewrite it
-- 					garden.Value = "loading"
-- 					local chaoExist = hit.Parent:FindFirstChild("Held",true)
-- 					print("Checking for Chao... ")
-- 					wait(0.03)
-- 					print(chaoExist)
-- 					if chaoExist then
-- 						print("Chao detected. This will take slighgtly longer")
-- 						local chao = chaoExist.Parent
-- 						chao.HumanoidRootPart.Weld:Destroy() --Unweld the chao so they don't mess up the camera
-- 						print("Teleporting...")
-- 						local isReturn = v:GetAttribute("isReturn")
-- 						local doorName = v:GetAttribute("DoorName")
-- 						if doorName then
-- 							local goal = getDoors(doorName)
-- 							if goal then
-- 								hit.Parent:MoveTo(goal) --Use MoveTo to prevent Humanoid Displacement
-- 								garden.Value = doorName
-- 							end
-- 						end
-- 						wait(0.5) --Pause for half a second to prevent bugs
-- 						chao:MoveTo(hit.Parent.HumanoidRootPart.Position)
-- 						chao.CFrame = hit.Parent.HumanoidRootPart.CFrame * CFrame.new(0,0,-1)
-- 						local weld = Instance.new("WeldConstraint")
-- 						weld.Part0 = hit.Parent.HumanoidRootPart
-- 						weld.Part1 = chao
-- 						weld.Name = "Weld"
-- 						weld.Parent = chao
-- 						debound = false
-- 					else
-- 						print("Teleporting...")
-- 						local isReturn = v:GetAttribute("isReturn")
-- 						local doorName = v:GetAttribute("DoorName")
-- 						if doorName then
-- 							local goal = getDoors(doorName)
-- 							if goal then
-- 								hit.Parent:MoveTo(goal) --Use MoveTo to prevent Humanoid Displacement
-- 								garden.Value = doorName
-- 							end
-- 						end
-- 						debound = false
-- 					end
-- 				end
-- 			end)
-- 		end
-- 	end
-- end



--function getDoors(doorName)
--	for l,z in pairs(workspace.Doors.Gate:GetChildren()) do
--		local temp = z:GetAttribute("DoorName")
--		if temp == doorName then
--			return z.Position
--			print("Found it!")
--		end
--	end
--end