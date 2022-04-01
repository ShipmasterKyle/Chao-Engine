local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.E then
		if script.Parent.Visible == true then
			script.Parent.Visible = false
		else
			script.Parent.Visible = true
		end
	end
end)