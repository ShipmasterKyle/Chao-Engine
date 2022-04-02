local module = {}

local changeSignals = {
	"Context",
	"Input",
	"ConsoleInput",
	"ObjectText",
	"Name"
}

function module.generateContextMenu(context,obj,Input,cInput,objectText)
	if context and obj then
		local contextMenu = Instance.new("ProximityPrompt")
		contextMenu.Name = context
		contextMenu.ActionText = context
		if Input then
			contextMenu.KeyboardKeyCode = Input
		end
		if cInput then
			contextMenu.GamepadKeyCode = cInput
		end
		if objectText then
			contextMenu.ObjectText = objectText
		end
		contextMenu.MaxActivationDistance = 15
		contextMenu.Parent = obj
	else
		warn("Missing Inputs")
	end
end

function module.updateContextMenu(obj,changeSignal,ctx)
	if obj and obj:IsA("ProximityPrompt") then
		if table.find(changeSignals,changeSignal,1) then
			if changeSignal == "Context" then
				obj.ActionText = ctx
			end
			if  changeSignal == "Input" then
				obj.KeyboardKeyCode = ctx
			end
			if changeSignal == "ConsoleInput" then
				obj.GamepadKeyCode = ctx
			end
			if changeSignal == "ObjectText" then
				obj.ObjectText = ctx
			end
			if changeSignal == "Name" then
				obj.Name = ctx
			end
		else
			warn("Invalid Change Signal")
		end
	else
		warn("Attempted to update nil or invalid object.")
	end
end

function module.destroyContextMenu(contextMenu)
	if contextMenu and contextMenu:IsA("ProximityPrompt") then
		contextMenu:Destroy()
		print("Destoyed Secessfully.")
	else
		warn("Attempted to destroy nil or invalid object")
	end
end

function module.getContextMenuProperty(obj,property)
	if obj and obj:IsA("ProximityPrompt") then
		if table.find(changeSignals,property,1) then
			if property == "Context" then
				return obj.ActionText
			end
			if property == "Input" then
				return obj.KeyboardKeyCode
			end
			if property == "ConsoleInput" then
				return obj.GamepadKeyCode
			end
			if property == "ObjectText" then
				return obj.ObjectText
			end
			if property == "Name" then
				return obj.Name
			end
		end
	else
		warn("Unable to get proprties of nil or invalid object.")
	end
end

function module:CreateChaoViewPort(chao, object, corner)
	if chao and chao:FindFirstChild("HumanoidRootPart") and object then
		local copyChao = chao:Clone()
		copyChao:MoveTo(Vector3.new(0,0,0))
		local frame = Instance.new("ViewportFrame")
		--TODO: Make this simply fill a frame
		frame.AnchorPoint = UDim.new(0.5,0.5)
		frame.Size = UDim2.new(0.128,0,0.226,0)
		frame.Position = UDim2.new(0.756,0,0.532,0)
		frame.BackgroundTransparency = 1
		frame.Parent = object
		local cam = Instance.new("Camera")
		cam.Parent = frame
		print(cam.Parent.Name)
		cam.FieldOfView = 45
		frame.CurrentCamera = cam
		local humroot = chao:FindFirstChild("HumanoidRootPart")
		cam.CFrame = CFrame.new(Vector3.new(0,2,12), humroot.Position)
		if corner then
			local uicorner = Instance.new("UICorner")
			uicorner.CornerRadius = UDim.new(0,20)
		end
	end
end


return module
