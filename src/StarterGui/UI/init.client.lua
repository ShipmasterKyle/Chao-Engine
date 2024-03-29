local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local MarketService = require(game.ReplicatedStorage.PublicDependancies.MarketService)
local ClassroomService = require(game.ReplicatedStorage.PublicDependancies.Classroom)
local CamService = require(game.ReplicatedStorage.PublicDependancies.CamService)
local Player = game:GetService("Players")
local RS = game:GetService("RunService")

--> For Garden Transitions
local ui = script.Parent.ScreenGui.Frame.GardenLogo
local garden = workspace.currentGarden


--for chao ui
local show = false

--> Fix wait
local wait = task.wait

function dprint(text,i)
    if workspace.Debug.Value == true or i then
        print(text)
    end
end

game.Players.PlayerAdded:Connect(function()
	dprint("New Player!")
	repeat wait(1) until game.Players.LocalPlayer.CharacterAppearanceLoaded == true
	dprint("Ready!")
	ui.Visible = true
	ui.Image = "rbxassetid://8596805320"
	wait(3)
	ui.Visible = false
end)

garden.Changed:Connect(function()
	dprint(garden.Value)
	if garden.Value ~= "loading" then
		local Tween = game:GetService("TweenService"):Create(ui, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
		if garden.Value == "Garden" then
			ui.Image = "rbxassetid://8596788034"
		elseif garden.Value == "Kindergarden" then
			ui.Image = "rbxassetid://8596801475"
		else
			ui.Image = "rbxassetid://8596805320"
		end
		wait(3)
		local Tween = game:GetService("TweenService"):Create(ui, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
		--ui.Visible = false
	else
		local Tween = game:GetService("TweenService"):Create(script.Parent.ScreenGui.Fade, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
		--script.Parent.ScreenGui.Fade.Visible = true
		wait(1.5)
		local Tween = game:GetService("TweenService"):Create(script.Parent.ScreenGui.Fade, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
		--script.Parent.ScreenGui.Fade.Visible = false
	end
end)

local plr = game.Players.LocalPlayer

workspace.kinder.Doctor.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local chaoExistence = plr.Character:FindFirstChild("Held", true)
		if chaoExistence then
			script.Parent.Classroom.Start.Visible = true
			local chao = chaoExistence.Parent
			UIService:CreateViewPort(chao,script.Parent.Basic,true)
		end
	end
end)

workspace.kinder.FortuneTeller.Touched:Connect(function()
	local chaoExistence = plr.Character:FindFirstChild("Held", true)
	if chaoExistence then
		script.Parent.Fortune_Teller.Frame.Visible = true
		script.Parent.StartFortune:Fire()
		local chao = chaoExistence.Parent
		CamService:NewCamPos(workspace.fortune.CamObj.Position,workspace.fortune.MainChair.Position)
	end
end)

--Will be added later
--workspace.kinder.Classroom.Touched:Connect(function()
--	local chao
--	local chaoExistence = plr.Character:FindFirstChild("Held", true)
--	if chaoExistence then
--		local chao = chaoExistence.Parent
--	end
--	script.Parent.StartClassroom:Fire(ClassroomService:GetCurrentLesson(),chao)
--end)

-- workspace.kinder.MsgBoard.ClickDetector.MouseClick:Connect(function()
-- 	script.Parent.Bulletin.Board.Visible = true
-- end)

game.ReplicatedStorage.Remotes.Market.OnClientEvent:Connect(function()
	local ourplate = script.Template
	local ourFram = script.Parent.Market.ImageLabel.ScrollingFrame
	MarketService:LoadMarket(ourFram,ourplate)
	script.Parent.Market.ImageLabel.Visible = true
end)

local chaoData = nil

plr.Character.ChildAdded:Connect(function(obj)
	if obj:FindFirstChild("ChaoController") and garden.Value == "Garden" then
		dprint("Chao Added: "..obj.Name,true)
		chaoData = plr.Leaderstats[obj.Name]
		if chaoData then
			dprint("New Chao Found",true)
			show = true
		end
	end
end)

plr.Character.ChildRemoved:Connect(function(obj)
	if obj:FindFirstChild("Held",true) then
		dprint("Chao Removed",true)
		show = false
		chaoData = nil
		script.Parent.ChaoMenu.Frame.Visible = false
	end
end)

--? RenderStepped should make the UI less laggy.
RS.RenderStepped:Connect(function()
	if chaoData ~= nil and show == true then
		if workspace.currentGarden.Value == "Garden" then
			script.Parent.ChaoMenu.Frame.Visible = true
			local frame = script.Parent.ChaoMenu.Frame
			frame.ChaoName.Text = chaoData.Name
			local main = frame.MainFrame
			main.SwimXP.Text = chaoData.SwimXP.Value
			main.SwimLvl.Text = "Lv "..chaoData.SwimLevel.Value
			main.FlyXP.Text = chaoData.FlyXP.value
			main.FlyLvl.Text = "Lv "..chaoData.FlyLevel.Value
			main.RunXP.Text = chaoData.RunXP.Value
			main.RunLvl.Text = "Lv"..chaoData.RunLevel.Value
			main.PowerXP.Text = chaoData.PowerXP.Value
			main.PowerLvl.Text = "Lv "..chaoData.PowerLevel.Value
			main.StaminaXP.Text = chaoData.StaminaXP.Value
			main.StaminaLvl.Text = "Lv "..chaoData.StaminaLevel.Value
		end
	end
end)

Player.LocalPlayer.PlayerGui:WaitForChild("Market").ImageLabel.ReadyPurchase.Event:Connect(function()
	Player.LocalPlayer.PlayerGui.Market.ImageLabel.Frame.Visible = true
end)