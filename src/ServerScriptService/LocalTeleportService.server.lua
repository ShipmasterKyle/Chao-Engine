local debound = false
local wait = task.wait
local garden = workspace.currentGarden

function getDoors(doorName)
	local found = false
	for i,v in pairs(workspace.Doors.Gate:GetChildren()) do
		local temp = v:GetAttribute("DoorName")
		if temp == doorName then
			found = true
			return v.Position
		end
	end
	if found == false then
		return false
	end
end

while wait() do
	for i,v in pairs(workspace.Doors:GetChildren()) do
		if debound == false then
			if v:IsA("Part") then
				debound = true
				v.Touched:Connect(function(hit)
					if hit.Parent:FindFirstChild("Humanoid") and not hit.Parent:FindFirstChild("Held") then
						local isReturn = v:GetAttribute("isReturn")
						local doorName = v:GetAttribute("DoorName")
						if doorName then
							local goal = getDoors(doorName)
							if goal then
								hit.Parent.HumanoidRootPart.Position = goal
								garden.Value = doorName
							end
						end
					end
				end)
				debound = false
			end
		end
	end
end



--function getDoors(doorName)
--	for l,z in pairs(workspace.Doors.Gate:GetChildren()) do
--		local temp = z:GetAttribute("DoorName")
--		if temp == doorName then
--			return z.Position
--			print("Found it!")
--		end
--	end
--end