--[[
    States
    Handles animating the chao

]]

--Collect the chao and the HumanoidObject
local chao = script.Parent
local hum = script.Parent.Humanoid
--Get the runtime.
local RS = game:GetService("RunService")

--Runs on every frame.
RS.Heartbeat:Connect(function()
    local currentlyPlaying = nil
    --Create an Animation Object
    local anim = Instance.new("Animation")
    --Define the hum's State
    local humState = hum:GetState()
    --Check the humState
    if humState == Enum.HumanoidStateType.Running then
        if currentlyPlaying ~= "Running" then
            currentlyPlaying =  "Running"
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