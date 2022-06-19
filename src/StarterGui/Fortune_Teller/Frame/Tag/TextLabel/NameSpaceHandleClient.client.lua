--[[
	NameSpaceHandleClient
	Handles the clientside of using NameSpaceService
]]

--Dependancies
local NameSpace = require(game.ReplicatedStorage.PublicDependancies.NameSpaceService)
local Cam = require(game.ReplicatedStorage.PublicDependancies.CamService)

--Bindables
local ourEvent = game.ReplicatedStorage.Remotes.StartFortune
local theirEvent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ShowMainOptions")
local nextEvent = game.Players.LocalPlayer.PlayerGui:WaitForChild("GenerateName")
local awaitReq = game.Players.LocalPlayer.PlayerGui:WaitForChild("AwaitApproval")
local awaitRes = game.Players.LocalPlayer.PlayerGui:WaitForChild("ApprovalSent")
local reName = game.Players.LocalPlayer.PlayerGui:WaitForChild("MakeName")
local event = game.ReplicatedStorage.Remotes.FinishName

--A simple boolean to track when write is running
local isTyping = false

--TODO: Put this on UIService
function write(text)
	isTyping = true
	for i = 1, #text do
		script.Parent.TextLabel.Text = string.sub(text, 1, i)
		wait(0.03)
	end
	isTyping = false
end

--A bunch messages that can show up when loading
local loadingMessages = {
	"Summoning the power of Brassmo",
	"Closing Tabs",
	"Aligning G-Force",
	"Watching Netflix",
	"Channeling inner Felipe",
	"Spinning Crystal Ball",
	"Checking DMs",
	"Subscibing to Flamingo",
	"Pressing like",
	"Generating life force",
	"Speedrunning Name Choosing",
	"Doing a barrel roll",
	"Playing Breakout",
	"Creating a new fan",
	"Scamming adopt me players",
	"Randomizing Collaterials",
	"Cleaning table",
	"Taking random books off the shelf",
	"Making naming potion",
	"Thinking of a really good name",
	"Reading Chao Island",
	"Calling Sonic Adventure 2",
	"Escaping from the city",
	"Streaming SnapCube",
	"Listening to Music",
	"Opening Pandora's Box",
	"Signing checks",
	"Discorvering Rewind Time",
	"Reviewing Mario Forces",
	"Raiding Area 51",
	"Reviewing IGN",
	"localizing Transcripts"
}

--Connect to the event that runs when players walk into the fortune telling house
ourEvent.OnClientEvent:Connect(function()
	write("Welcome to the fortune telling house. You won't get ou fortune told here but I can give your chao a good name.")
	wait(0.03)
	repeat wait(0.03) until isTyping == false
	write("Should I name your chao or will you?")
	theirEvent:Fire()
end)

--Connect to the event for when players ask for a randomized name
nextEvent.Event:Connect(function()
	--A loop that makes it so the random messages play
	for count = 1,4 do
		local rand = math.random(#loadingMessages)
		write(loadingMessages[rand])
		wait(1)
	end
	write("Summoning Powers to be...")
	--wait until its finished typing
	wait(0.03)
	repeat wait(0.03) until isTyping == false
	local newName = NameSpace:GenerateName()
	write("How about the name "..newName.."?")
	awaitReq:Fire("ChaoName",newName)
end)

--Connect to the response (res) of the request(req). Here quest is the data that needed to be approved
awaitRes.Event:Connect(function(req,res,quest)
	if req == "ChaoName" then
		if res == "Approved" then
			--Get the chao from the player so we can name them.
			local chaoExistence = game.Players.LocalPlayer.Character:FindFirstChild("Held", true)
			game.ReplicatedStorage.Remotes.NameChao:FireServer(chaoExistence.Parent,req)
		elseif res == "Declined" then
			write("Oh really? Would like to name them yourself or should I make another name?")
			--Send the request again as a diiferent request.
			awaitReq:Fire("NameIt")
		end
	elseif req == "NameIt" then
		if res == "Approve" then
			--Send the event for the player to name the chao themself
			reName:Fire()
		elseif res == "Decline" then
			--rerun nextEvent 
			--A loop that makes it so the random messages play
			for count = 1,4 do
				local rand = math.random(#loadingMessages)
				write(loadingMessages[rand])
				wait(1)
			end
			write("Summoning Powers to be...")
			--wait until its finished typing
			wait(0.03)
			repeat wait(0.03) until isTyping == false
			local newName = NameSpace:GenerateName()
			write("How about the name "..newName.."?")
			awaitReq:Fire("ChaoName",newName)
		end
	end
end)

event.OnClientEvent:Connect(function(name)
	write(name.." is a wonderful name. Come again soon!")
	repeat wait(0.03) until isTyping == false
	Cam:StopCam()
end)