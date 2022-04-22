--[[
    Notes about the Game and the Datastore

    XP, Levels, and Ranks
        XP Levels and Ranks go hand in hand. XP is simply your XP which
        is used to determined your levels
                
        [NOTE: XP uses a simple math equation to determin your level.
        Its just Level = math.floor(XP/100). So if you had 5450 XP your level would be 54.]

        XP Is recieved from Chaos Drives, Chao Fruits, Animals and Wisps.
        How much XP you get from these items determined by your rank.

        [NOTE: Theres another simple math equation to determine how much
        XP you'd get from food inferring you know the base XP. Its
        x*Rank = y where x is the baseXP and y is the final X. You will 
        never get no XP and will never lose XP. The lowest rank is 1 which
        is an E. The last bite of food also is the most healthy as it gives
        the most XP.]

        Ranks are valued from 1-6. 1 is and E while 6 is an S. It is impossible
        to get an S Rank from a new non-breed chao egg (such as the starter eggs
        or from the market) S Rank are earned from A Rank Chaos the evolve. This
        is covered in Evolution. Ranks serve as a multiplier of sorts that increase
        the amount of XP earned an thus decrease the time it takes to get certain
        skills

        Levels are important for ChaoStates. Many animations are dependant on the chao
        states for example the run anim changes depending on your run level, will change
        from a defualt crawl to a fast run.

        Theses skills help your chao in races.
    States
        ChaoStates are important to animations and allows for them to rendered correctly.
        For example if Chao are really hungry and the player holds out some food, nearby
        Chao will run towards the player with the fast run anim and then jump for the 
        food. States determine how the chao feels. Chao generally have these 8 main states. 
                [
                    Thinking
                        This is the state that chao will be in when they're choosing what
                        to do next. VisualService will make a "?" appear above their head.
                    
                    Running
                        In this state chao will simply be walking around depnding on their 
                        animation. Once they finish they will return to the Thinking or Idle
                        state.
                    Idle
                        In this state the chao is standing still. This state is brief, only
                        lasting a few seconds and usually transitions into the thinking state.
                    Swimming
                        A state that runs when the chao is touching water.
                    Eating
                        A state that is active when the chao has been given food. It usaully
                        is recieved from the running or sitting state. Some states are 
                        blocked from sending a state change to this state. Chao will either go
                        into the sleeping or running state afterwards
                    Siiting
                        A state where a chao is simply sitting. This state does not make Chao 
                        less tired. This state is always followed by the thinking or sleeping 
                        state. It can only be interupted by the held or eating state changes.
                    Sleeping
                        A state where chao is sleeping. This state occurs when the chao has an
                        energy value <= 50. This state can be interupted by the Held state but
                        will decrease a Chao's Happiness. This state is the only state where
                        chao will naturally increase their states without any physical object.
                        This state lasts about 15 - 20 minutes.
                    Flying
                        A state where the chao is trying to fly. If they can actually fly then
                        their FreeFall decent will be slower. Followed by the running state
                    Held
                        A state that is only able to be triggered when the chao's held state
                        is true.
                ]
    Services
        ChaoModule
            ChaoModule is a high level service responsible for general chao handling. This
            includes, leveling, stats, Evolution and more. It actively uses serveral other services
            to get tasks done.
        ClassService
            ClassService is responsible for the class tree that the game uses to spawn usable items.
            Most of its uses are using metadata Class in game.ReplicatedStorage.MarketPlace
            to spawn physical items that players can use.
        MarketService
            MarketService is used specifically to display items in the Chao Black Market. It uses
            MarketData to determine if items are onsale, items decriptions and physical appearances.
            It also uses ClassService to give players items by sending some metadata.
        NameSpaceService
            NameSpaceService is a special purpose service that is responsible for naming chao. It has
            3 functions: GenerateName() which uses its name table to pick a name, ModerateName() which
            uses Roblox's TextService to prevent TOS breaking names and FinalizeName() that saves
            the chao name to the server.
        UIService
            UIService is a high level service responsible for general UI handling. This includes the
            ContextMenus that ContextMenuController uses, ViewportFrames and more. Many files are
            dependant on it.
        VisualService
            VisualService is a high level service repsonsible for coloring chao. It does not save any
            data and is simply responsible for the clientside appearence of them.
]]