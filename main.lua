-- Load Tokyo UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/1%20Tokyo%20Lib%20(FIXED)/Tokyo%20Lib%20Source.lua"))({
    cheatname = "Monster GUI",
    gamename = "Explorer"
})

library:init()

-- Setup
local Decimals = 4
local Clock = os.clock()

-- Create Window
local Window = library.NewWindow({
    title = "Monster Viewer | Tokyo UI",
    size = UDim2.new(0, 510, 0.6, 6)
})

-- Tabs and Sections
local Tab = Window:AddTab(" Monsters ")
local Section = Tab:AddSection(" Select Area ", 1)

-- Forward declaration for monster dropdown
local monsterListRef = nil

-- Load Level list from workspace.Levels
local LevelsFolder = workspace:FindFirstChild("Levels")
local levelList = {}

if LevelsFolder then
    for _, lvl in ipairs(LevelsFolder:GetChildren()) do
        table.insert(levelList, lvl.Name)
    end
end

-- Track selected level
local selectedLevel = nil

-- ComboBox 1: Level Selector
Section:AddList({
    enabled = true,
    text = "Select Level",
    tooltip = "Choose a Level or Activity",
    selected = "",
    values = levelList,
    multi = false,
    open = false,
    max = 6,
    callback = function(levelName)
        selectedLevel = levelName

        -- Auto-update monster list
        local monsters = {}
        local folder = LevelsFolder:FindFirstChild(levelName)
        if folder then
            local monsterFolder = folder:FindFirstChild("Monsters")
            if monsterFolder then
                for _, m in ipairs(monsterFolder:GetChildren()) do
                    table.insert(monsters, m.Name)
                end
            end
        end

        -- Update ComboBox2 with monster names
        monsterListRef:SetValues(monsters)
    end
})

-- ComboBox 2: Monster Selector
monsterListRef = Section:AddList({
    enabled = true,
    text = "Select Monster",
    tooltip = "Choose a monster after selecting level",
    selected = "",
    values = {}, -- starts empty
    multi = false,
    open = false,
    max = 6,
    callback = function(monster)
        print("Selected Monster:", monster)
    end
})

-- Show load time
local Time = (string.format("%."..tostring(Decimals).."f", os.clock() - Clock))
library:SendNotification("Monster UI Loaded in " .. Time .. "s", 6)
