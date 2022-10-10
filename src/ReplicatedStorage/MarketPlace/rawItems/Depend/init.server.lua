--[[
    Depend
    Reduce the number of scripts in the rawItems folder
]]

while wait() do
    for i, v in pairs(script.Parent:GetDescendants()) do
        if v:IsA("Model") or (v:IsA("BasePart") and v.Parent == script.Parent) then
            if not v:FindFirstChild("PickScript") then
                local copy = script.PickScript:Clone()
                copy.Parent = v
            end
        end
        if v:IsA("BasePart") and v.Parent ~= script.Parent then
            if not v:FindFirstChild("Float") then
                local copy = script.Float:Clone()
                copy.Parent = v 
            end
        end
    end
end