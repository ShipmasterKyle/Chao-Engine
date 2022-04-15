local chao = script.Parent
local hum = script.Parent.Humanoid
local RS = game:GetService("RunService")

RS.Heartbeat:Connect(function()
    local currentlyPlaying = nil
    local anim = Instance.new("Animation")
    local humState = hum:GetState()
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