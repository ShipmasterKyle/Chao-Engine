--[[
    VisualService
    A service used to changethe visual appearance of chao based on their stats
]]

local service = {}

--A Class Table for Emotion Ball Types
local headTypes = {
    Hero = {
        Name = "Hero",
        ID = ""
    },
    Dark = {
        Name = "Dark",
        ID = ""
    },
    Normal = {
        Name = "Normal",
        ID = ""
    },
}

--Alternative table.find
function service.GetArrayItem(item,array)
    for i,v in pairs(array) do
        if v.Name == item then
            return v
        else end
    return false
    end
end

--Changes the emotion ball
function service:ChangeHeadType(chao,headType)
    if service.GetArrayItem(headTypes,headType)  then
        chao.Emotion.MeshPart.Mesh = service.GetArrayItem(headTypes,headType).ID
        print("HeadType Changed")
    else
        warn("Invalid HeadType")
    end
end

function service:ChangeChaoType(chao,chaoType)
    
end

return service