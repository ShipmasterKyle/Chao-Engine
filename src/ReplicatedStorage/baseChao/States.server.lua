--[[
    States
    Handles animating the chao
]]

--Collect the chao and the HumanoidObject
local chao = script.Parent
local hum = script.Parent.Humanoid
--Get the runtime.
local RS = game:GetService("RunService")
--ChaoState
local ChaoState = "none"

--Runs on every frame.
RS.Heartbeat:Connect(function()
	local currentlyPlaying = nil
	--Create an Animation Object
	local anim = Instance.new("Animation")
	--Define the hum's State
	local humState = hum:GetState()
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
end)

--Change the chao's state to swimming if they're touching a part named "Water"
script.Parent.Touched:Connect(function(hit)
	if hit.Name == "Water" then
		ChaoState = "Swimming"
	else
		ChaoState = "none"
	end
end)