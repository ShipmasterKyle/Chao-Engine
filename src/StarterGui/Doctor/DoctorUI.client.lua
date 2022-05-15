local chaoService = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local UIS = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local chao

local on = false

normalReply = {
	"Oh no! Your chao is perfectly healthy.";
	"This can't be! Your chao is fine.";
	"Nothing is wrong with your chao.";
	"Your chao is very healthy!";
	"Your chao isn't sick."
}

bhvReply = {
	"Looks like this Chao likes music.",
	"Looks like this Chao likes to dance.",
	"Looks like this Chao likes to draw.",
	"Looks like this Chao likes toys.",
	"Looks like this Chao likes TV.",
	"Looks like this Chao likes listening to music.",
	"Looks like this Chao likes to fly.",
	"Looks like this Chao is afraid of heights.",
	"Looks like this Chao likes to swim.",
	"Looks like this Chao doesn't like swimming.",
	"Looks like this Chao likes to climb trees.",
	"Looks like this Chao likes naps.",
}

images = {
	"http://www.roblox.com/asset/?id=8888502969",
	"http://www.roblox.com/asset/?id=8888496721",
	"http://www.roblox.com/asset/?id=7921523503",
	"http://www.roblox.com/asset/?id=8888481815",
	"http://www.roblox.com/asset/?id=8888475280",
	"http://www.roblox.com/asset/?id=8888468390"
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
	if chao then
		for i,v in pairs(script.Parent.Frame.Basic:GetChildren()) do
			if v:IsA("TextLabel") then
				if chaoService:GetStats(chao.Id.Value,game.Players.LocalPlayer,v.Name) then
					v.Text = chaoService:GetStats(chao.Id.Value,game.Players.LocalPlayer,v.Name)
				end
			end
			if v:IsA("ImageLabel") then
				v.Image = images[chaoService:GetStats(chao.Id.Value,game.Players.LocalPlayer,v.Name)]
			end
		end
	end
end

while wait() do
	if on == true then
		for i,v in pairs(script.Parent.Start:GetChildren()) do
			--This is only ever gonna run if they have a chao
			chao = plr.Character:FindFirstChild("Held", true)
			if chao then
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
end

script.Parent.Start:GetPropertyChangedSignal("Visible"):Connect(funcion()
	if script.Parent.Visible == false then
		on = false
	elseif script.Parent.Visible == true then
		on = true
	end
end)