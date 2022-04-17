local service = {}

local current = script.Parent.currentClass

local lessons = {
    "Song",
    "Shake Dance",
    "Drawing",
    "Bell",
    "Drum",
    "Song",
    "Spin Dance",
    "Tambourine",
    "Drawing",
    "Trumpet",
}

function service:GetCurrentLesson()
    return current
end

function service:ChangeClass(currentClass)
    local lastClass = lessons[current]
    local newClass = lastClass += 1
    current.Value = newClass 
end

function service:LearnLesson(chaoData)
    chaoData.InProgressLesson.Value = current
    chaoData.LessonStartTime.Value = os.time()
end

function service:IsLessonDone(chaoData)
    local finishTime = LessonStartTime + 14400
    if os.time > finishTime then
        return "Done"
    else
        return "Incomplete"
    end
end

return service