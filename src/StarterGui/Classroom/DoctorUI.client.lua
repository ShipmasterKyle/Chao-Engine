local chaoService = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local UIS = game:GetService("UserInputService")

local on = true
local canScroll = false

normalReply = {
	"Oh no! Your chao is perfectly healthy.";
	"Your chao seems fine.";
	"Nothing is wrong with your chao.";
	"Your chao is very healthy!";
	"Your chao isn't sick."
}

function write()
	local rng = math.random(#normalReply)
	local text = normalReply[rng]
	for i = 1, #text do
		script.Parent.TextLabel.Text = string.sub(text, 1, i)
		wait(0.03)
	end
	on = false
end

while wait() do
	if on == true then
		for i,v in pairs(script.Parent.Start:GetChildren()) do
			if v:IsA("TextButton") then
				v.MouseEnter:Connect(function()
					v.UIStroke.Thickness = 5
				end)
				v.MouseLeave:Connect(function()
					v.UIStroke.Thickness = 0
				end)
				v.MouseButton1Click:Connect(function()
					if v.Name == "Look" then
						on = false
						write()
					elseif v.Name == "Charts" then
						script.Parent.Start.Visible = false
						canScroll = true
						script.Parent.Frame.Visible = true
						script.Parent.Frame.UIPageLayout:JumpToIndex(0)
					end
				end)
			end
		end
	end
end


UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonR1 then
		if canScroll then
			script.Parent.Frame.UIPageLayout:Next()
		end
	end
	if input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.ButtonL1 then
		if canScroll then
			script.Parent.Frame.UIPageLayout:Previous()
		end
	end
	if input.KeyCode == Enum.KeyCode.B or input.KeyCode == Enum.KeyCode.ButtonB then
		if canScroll then
			script.Parent.Frame.Visible = false
			canScroll = false
			script.Parent.Start.Visible = true
		end
	end
end)