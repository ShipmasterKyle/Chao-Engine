--[[
    NameSpaceService
    Handles naming chao
]]

math.randomseed(tick())
local TS = game:GetService("TextService")

local module = {}

local Names = {
	"Ajax",
	"Atom",
	"Bingo",
	"Brandy",
	"Bruno",
	"Bubbles",
	"Buddy",
	"Buzzy",
	"Cash",
	"Casino",
	"Chacha",
	"Chacky",
	"Chaggy",
	"Chai",
	"Chalulu",
	"Cham",
	"Champ",
	"Chang",
	"Chaofun",
	"Chaoko",
	"Chaolin",
	"Chaorro",
	"Chaosky",
	"Chap",
	"Chapon",
	"Chappy",
	"Charon",
	"Chasm",
	"Chaz",
	"Cheng",
	"Choc",
	"Cholly",
	"Chucky",
	"Cody",
	"Cuckoo",
	"DEJIME",
	"Dash",
	"Dingy",
	"Dino",
	"Dixie",
	"Echo",
	"Edge",
	"Elvis",
	"Emmy",
	"Flamingo",
	"Fuzzie",
	"Groom",
	"HITM",
	"Hiya",
	"Honey",
	"Jojo",
	"Keno",
	"Kosmo",
	"Loose",
	"Melody",
	"NAGOSHI",
	"OVER",
	"Papoose",
	"Peaches",
	"Pebbles",
	"Pinky",
	"Quartz",
	"Quincy",
	"RUSSO",
	"Rascal",
	"Rocky",
	"Rover",
	"Roxy",
	"Rusty",
	"SMILEB",
	"SOUL",
	"Spike",
	"Star",
	"Tango",
	"Tiny",
	"WOW",
	"Woody",
	"YS",
	"Zack",
	"Zippy"
}

function module:GenerateName()
	local rng = math.random(#Names)
	return Names[rng]
end

function module:ModerateName(name,player)
	return TS:FilterStringAsync(name,player.UserId)
end

function module:FinalizeName(name,chao,player)
	player.Leaderstats[chao.Name].ChaoName = name
	chao.Name = name 
end

return module