local module = {}

local changeSignals = {
	"Context",
	"Input",
	"ConsoleInput",
	"ObjectText",
	"Name"
}

function module:GenerateContextMenu(context,obj,Input,cInput,objectText)
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
		contextMenu.RequiresLineOfSight = false
	else
		warn("Missing Inputs")
	end
end

function module:UpdateContextMenu(obj,changeSignal,ctx)
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

function module:DestroyContextMenu(contextMenu)
	if contextMenu and contextMenu:IsA("ProximityPrompt") then
		contextMenu:Destroy()
		print("Destoyed Secessfully.")
	else
		warn("Attempted to destroy nil or invalid object")
	end
end

function module:GetContextMenuProperty(obj,property)
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

function module:CreateChaoViewPort(chao, object, corner, returnItem)
	if chao and chao:FindFirstChild("HumanoidRootPart") and object then
		local copyChao = chao:Clone()
		copyChao:MoveTo(Vector3.new(0,0,0))
		local id = Instance.new("StringValue", copyChao)
		id.Value = chao.Name
		id.Name = "Id"
		copyChao.Name = "TempChao"
		copyChao.Parent = workspace
		local frame = Instance.new("ViewportFrame")
		frame.AnchorPoint = UDim.new(0,0)
		frame.Size = UDim2.new(1,0,1,0)
		frame.Position = UDim2.new(0,0,0,0)
		frame.BackgroundTransparency = 1
		frame.Parent = object
		frame.Visible = false
		frame.Name = "ChaoPort"
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
			uicorner.Parent = object
		end
		if returnItem == true then
			return frame
		end
	end
end

function module:CreateItemViewport(item, object, corner, returnItem)
	if item and object then
		local copyCat = item:Clone()
		copyCat:MoveTo(Vector3.new(0,0,0))
		copyCat.Parent = workspace.TempStorage
		local frame = Instance.new("ViewportFrame")
		frame.AnchorPoint = UDim.new(0,0)
		frame.Size = UDim2.new(1,0,1,0)
		frame.Position = UDim2.new(0,0,0,0)
		frame.BackgroundTransparency = 1
		frame.Parent = object
		local cam = Instance.new("Camera")
		cam.Parent = frame
		print(cam.Parent.Name)
		cam.FieldOfView = 45
		frame.CurrentCamera = cam
		cam.CFrame = CFrame.new(Vector3.new(0,2,12), item.Position)
		if corner then
			local uicorner = Instance.new("UICorner")
			uicorner.CornerRadius = UDim.new(0,20)
			uicorner.Parent = object
		end
		if returnItem == true then
			return frame
		end
	end
end

return module