local service = {}
local cam = workspace.CurrentCamera

function service:NewCamPos(campos,camfocus)
	cam.CameraType = Enum.CameraType.Scriptable
	cam:Interpolate(CFrame.new(campos), CFrame.new(camfocus), .2)
end

function service:StopCam()
	cam.CameraType = Enum.CameraType.Custom
end

return service
