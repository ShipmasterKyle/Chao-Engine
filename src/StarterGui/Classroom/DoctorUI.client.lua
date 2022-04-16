--[[
	DoctorUI
	Handles the Doctor Office.
]]

local chaoService = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local UIS = game:GetService("UserInputService")

local on = true

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

function fillData(chaoData)
	--Uses the chaoService:GetStat() to set the data of the pages. Also UIService:CreateChaoViewPort() for the first page with the visial of your chao. 
	--Basic Frame
	local topFrame = script.Parent.Frame
	local basic = topFrame.Basic
	local chao = workspace.TempChao
	basic.Attributes.Text = chaoService:GetStats(chao.Id.Value,game.Players.LocalPlayer,"Attribute")
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
						script.Parent.Frame.Visible = true
					end
				end)
			end
		end
	end
end