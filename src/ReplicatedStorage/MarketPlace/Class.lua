--[[
    Class
    A simple class tree for every item in the game.
]]

local tree = {
    Chao = {
        Name = "Chao",
        WoolHat = {
            Name = "Wool Hat",
            Desc = "A warm hat for your chao.",
            isDecor = true,
            Value = "1000",
        }
    },
    Food = {
        Name = "Food",
        Fruit = {
            Name = "Garden Fruit",
            Desc = "A regular fruit.",
            isDecor = false,
            Value = "50",
        },
        SFruit = {
            Name = "Square Fruit",
            Desc = "A square shaped fruit. Some chao love this.",
            isDecor = false,
            Value = "100"
        },
        RFruit = {
            Name = "Round Fruit",
            Desc = "A round shaped fruit. Some chao love this.",
            isDecor = false,
            Value = "125"
        },
        TFruit = {
            Name = "Triangle Fruit",
            Desc = "A triangle shaped fruit. Some chao love this.",
            isDecor = false,
            Value = "150"
        },
        StFruit = {
            Name = "Strong Fruit",
            Desc = "Help your chao grow stronger. (Power +4)",
            isDecor = false,
            Value = "200",
        },
        TaFruit = {
            Name = "Tasty Fruit",
            Desc = "A tasty fruit that all chao love. Its great for their health too.",
            isDecor = false,
            Value = "350",
        },
        HFruit = {
            Name = "Heart Fruit",
            Desc = "A sweet tasting fruit that gets chao ready to mate.",
            isDecor = false,
            Value = "500",
        },
        SMFruit = {
            Name = "Smart Fruit",
            Desc = "A fruit with riveting flavor that helps your chao learn.",
            isDecor = false,
            Value = "500",
        },
        Mint = {
            Name = "Mint Candy",
            Desc = "A lucky piece of candy sure to give your chao tons of energy. (Luck +25)",
            isDecor = false,
            Value = "800"
        }
    },
    Toys = {
        Name = "Toys",
        Car = {
            Name = "Toy Car",
            Desc = "A Toy Car that can be won from Chao Races",
            isDecor = false,
            Value = "-1000"
        }
    },
    Animals = {
        Name = "Animal",
        Wisps = {
            Name = "Wisps",
            White = {
                Name = "White Wisp",
                Desc = "The White Wisp. Helps make your chao faster. (Running +3)",
                isDecor = false,
                Value = "250"
            },
            Red = {
                Name = "Red Wisp",
                Desc = "The Red Wisp. Helps make your chao stronger. (Power +3)",
                isDecor = false,
                Value = "250"
            },
            Cyan = {
                Name = "Cyan Wisp",
                Desc = "The Cyan Wisp. Helps your chao swim better. (Swim +3)",
                isDecor = false,
                Value = "250"
            },
            Green = {
                Name = "Green Hover",
                Desc = "The Green",
                isDecor = false,
                Value = "250"
            }
        },
        Animals = {
            Name = "Animals",
            Gorrilla = {
                Name = "Monke",
                Desc = "The Gorrilla Animal. Found thoughout stages. Helps make your chao stronger at the cost of its flying skill. (Power +7) (Flying -3)",
                isDecor = false,
                Value = "250"
            }
        },
        ChaoDrives = {
            Name = "ChaoDrive",
            Run = {
                Name = "RunDrive",
                Desc = "The run chao drive. Increases your chao's running skill. Effectiveness depends on Chao's rank in running.",
                isDecor = false,
                Value = "-1"
            },
            Fly = {
                Name = "FlyDrive",
                Desc = "The fly chao drive. Increases your chao's flying skill. Effectiveness depends on Chao's rank in flying.",
                isDecor = false,
                Value = "-1"
            },
            Swim = {
                Name = "SwimDrive",
                Desc = "The swim chao drive. Increases your chao's swimming skill. Effectiveness depends on Chao's rank in swimming.",
                isDecor = false,
                Value = "-1"
            },
            Power = {
                Name = "PowerDrive",
                Desc = "The power chao drive. Increases your chao's power skill. Effectiveness depends on Chao's rank in power.",
                isDecor = false,
                Value = "-1"
            },
        },
    },
    Medals = {
        Name = "Medals"
    }
}

return tree