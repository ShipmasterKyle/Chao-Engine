local UIS = game:GetService("UserInputService")

local shakeBind = Enum.KeyCode.X
local debounce = false


UIS.InputBegan:Connect(function(input)
	if input.KeyCode == shakeBind then
		if script.Parent:FindFirstChild("Egg") and debounce == false then
			debounce = true
			--Play Shake Tween or smth
			script.Parent.Egg.HatchTime -= 20
			print("Shoke")
			wait(2)
			debounce = false
		end
	end
end)