local service = {}
local cam = workspace.CurrentCamera

--[[
	NewCamPos
	Moves the camera to a new locations with interpolate
]]
function service:NewCamPos(campos,camfocus)
	cam.CameraType = Enum.CameraType.Scriptable
	cam:Interpolate(CFrame.new(campos), CFrame.new(camfocus), .2)
end

--[[
	StopCam
	Resets the camera
]]
function service:StopCam()
	cam.CameraType = Enum.CameraType.Custom
end

return service
