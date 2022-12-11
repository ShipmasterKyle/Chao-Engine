local PromptService = game:GetService("ProximityPromptService")
local UIS = game:GetService("UserInputService")
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local VisualService = require(game.ReplicatedStorage.PublicDependancies.VisualService)

local consoleInputs = {
    [Enum.KeyCode.ButtonX] = "X",
	[Enum.KeyCode.ButtonY] = "Y",
	[Enum.KeyCode.ButtonA] = "A",
	[Enum.KeyCode.ButtonB] = "B",
}

local function getScreenGui()
	local screenGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ProximityPrompts")
	if screenGui == nil then
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = "ProximityPrompts"
		screenGui.ResetOnSpawn = false
		screenGui.Parent = game.Players.LocalPlayer.PlayerGui
	end
	return screenGui
end

function dprint(text,i)
    if workspace.Debug.Value == true or i then
        print(text)
    end
end

PromptService.PromptShown:Connect(function(prompt, inputType)
    --Get details about the prompt
    local promptStatus = UIService:GetContextMenuProperty(prompt,"Name")
    --Use that data to determine what we want to do
    local gui = getScreenGui()
    if promptStatus == "OpenMenu" then
        --Assert that the prompt style is correct
        dprint(UIService:GetContextMenuProperty(prompt,"Style"))
        if UIService:GetContextMenuProperty(prompt,"Style") == Enum.ProximityPromptStyle.Custom then
            local proxprompt = game.Players.LocalPlayer.PlayerGui.ChaoPrompt
            if inputType == Enum.ProximityPromptInputType.Gamepad then
                proxprompt.ButtonMain.Button.Text = consoleInputs[UIService:GetContextMenuProperty(prompt,"ConsoleInput")]
            else
                proxprompt.ButtonMain.Button.Text = UIS:GetStringForKeyCode(UIService:GetContextMenuProperty(prompt,"Input"))
            end
            proxprompt.ButtonMain.Button.Visible = true
            proxprompt.Main.ActionMain.Position = UDim2.new(1,0,0.089,0)
            proxprompt.Main.Visible = true
            proxprompt.Main.ActionMain:TweenPosition(UDim2.new(-0.014,0,0.089,0),Enum.EasingDirection.In,Enum.EasingStyle.Sine,0.2)
            proxprompt.Main.ActionText.Visible = true
            local update = coroutine.wrap(function()
                while wait(1) do
                    if proxprompt.Main.ActionText.Text ~= UIService:GetContextMenuProperty(prompt,"Context") then
                        proxprompt.Main.ActionText.Text = UIService:GetContextMenuProperty(prompt,"Context")
                    end
                end
            end)
            update()
            prompt.PromptHidden:Connect(function()
                dprint("Hidden")
                proxprompt.Main.Visible = false
                proxprompt.Main.ActionText.Visible = false
                proxprompt.ButtonMain.Button.Visible = false
            end)
        end
    end
end)